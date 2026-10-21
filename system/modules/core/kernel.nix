{ pkgs, ... }:
{
  # TODO: remover quando estes PRs chegarem no nixos-unstable
  # (módulos externos precisam passar por modules_install para serem assinados)
  boot.kernelPackages = pkgs.linuxPackages.extend (
    _: super: {
      # https://github.com/NixOS/nixpkgs/pull/575861
      v4l2loopback = super.v4l2loopback.overrideAttrs (old: {
        preBuild = "";
        installFlags = (old.installFlags or [ ]) ++ [
          "DEPMOD=true"
          "INSTALL_MOD_PATH=${placeholder "out"}"
        ];
      });

      # https://github.com/NixOS/nixpkgs/pull/575394
      acpi_call = super.acpi_call.overrideAttrs (old: {
        makeFlags = old.makeFlags ++ [
          "INSTALL_MOD_PATH=${placeholder "out"}"
          "INSTALL_MOD_DIR=misc"
          "DEPMOD=true"
        ];
        installPhase = null;
        postInstall = ''
          install -D -m755 examples/turn_off_gpu.sh $out/bin/test_discrete_video_off.sh
        '';
      });
    }
  );
}
