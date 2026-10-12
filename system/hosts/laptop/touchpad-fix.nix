# Conserto do touchpad (ThinkBook 14 G6 IRL) — Focaltech FTCS0038.
#
# Bug: uma atualizacao de BIOS passou a gravar 0 no campo NVS "GPDI" (o pino de
# interrupcao GPIO do touchpad). Com GPDI=0 o driver i2c_hid resolve a IRQ para
# a linha GPIO 0 (errada) e falha ("Could not register interrupt ... -22").
# Por isso o touchpad funciona na BIOS mas em nenhum sistema operacional.
#
# Correcao (validada funcionando): no boot, escrevemos o valor correto em GPDI
# (grupo 14, pino 18 -> 0x090E0012 == linha GPIO 338, pad DDP1_CTRLCLK, o pino
# fisico da interrupcao), re-executamos o metodo ACPI _INI do touchpad (que
# recomputa o GpioInt a partir do GPDI) e re-enumeramos o barramento I2C para o
# driver reprovar com a IRQ correta. Nao mexe na BIOS.
#
# (Tentamos antes um override de DSDT no initrd, mais "limpo", mas o _INI nao
# roda automaticamente no boot dessa placa e a correcao nao pegava; esta via em
# runtime e a que comprovadamente funciona.)
#
# Requer:
#   - acpi_call: para avaliar \_SB.PC00.I2C0.TPD0._INI em runtime.
#   - iomem=relaxed: para escrever 4 bytes em /dev/mem (regiao ACPI NVS).
{ config, pkgs, lib, ... }:

{
  boot.extraModulePackages = [ config.boot.kernelPackages.acpi_call ];
  boot.kernelModules = [ "acpi_call" ];
  boot.kernelParams = [ "iomem=relaxed" ];

  systemd.services.thinkbook-touchpad-fix = {
    description = "Corrige a IRQ GPIO do touchpad Focaltech (bug de BIOS: GPDI=0)";
    wantedBy = [ "multi-user.target" ];
    after = [ "systemd-modules-load.service" ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
    };
    path = [ pkgs.coreutils ];
    script = ''
      set -u

      # Endereco fisico de GPDI = base da GNVS (0x05D50000) + offset 0x479.
      ADDR=$(( 0x05D50479 ))

      # Valor correto: grupo 14, pino 18 -> LE 0x12 0x00 0x0E 0x09 (== 0x090E0012).
      printf '\x12\x00\x0e\x09' | dd of=/dev/mem bs=1 seek=$ADDR conv=notrunc status=none 2>/dev/null || {
        echo "falha ao escrever GPDI em /dev/mem (iomem=relaxed ativo?)"; exit 0; }

      # Confere a escrita.
      GOT=$(dd if=/dev/mem bs=1 count=4 skip=$ADDR iflag=skip_bytes status=none 2>/dev/null | od -An -tx1 | tr -d ' \n')
      [ "$GOT" = "12000e09" ] || { echo "GPDI nao gravou (leu $GOT); abortando"; exit 0; }

      # Recomputa o GpioInt do touchpad a partir do GPDI corrigido.
      echo '\_SB_.PC00.I2C0.TPD0._INI' > /proc/acpi/call 2>/dev/null || true

      # Re-enumera o barramento I2C do touchpad para reprovar com a IRQ correta.
      if [ -e /sys/bus/platform/drivers/i2c_designware/i2c_designware.0 ]; then
        echo i2c_designware.0 > /sys/bus/platform/drivers/i2c_designware/unbind 2>/dev/null || true
        sleep 0.5
        echo i2c_designware.0 > /sys/bus/platform/drivers/i2c_designware/bind 2>/dev/null || true
      fi
    '';
  };

  # No resume da hibernacao a BIOS executa de novo e volta a gravar GPDI=0,
  # entao o fix precisa ser reaplicado. O restart re-executa o oneshot acima
  # (RemainAfterExit o deixa "active", por isso restart e nao start). O script
  # e idempotente, entao rodar tambem no resume de suspend simples nao faz mal.
  powerManagement.resumeCommands = ''
    ${config.systemd.package}/bin/systemctl restart thinkbook-touchpad-fix.service
  '';
}
