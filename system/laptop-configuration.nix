{ config, pkgs, lib, ... }:

{
  nixpkgs.config.allowUnfree = true;
  imports = [ ./configuration.nix ];

  boot = {
    kernel.sysctl = {
      "vm.vfs_cache_pressure" = 50;
      "vm.swappiness" = 5;
      "vm.watermark_scale_factor" = 500;
      "net.ipv4.tcp_congestion_control" = "bbr";
      "vm.overcommit_memory" = 1;
      "net.ipv4.ip_forwarding" = 1;
      "net.ipv6.conf.all.forwarding" = 1;
    };
    plymouth = {
      enable = true;
      theme = "blockchain";
      themePackages = with pkgs;
        [
          (adi1090x-plymouth-themes.override {
            selected_themes = [ "blockchain" ];
          })
        ];
    };
    consoleLogLevel = 0;
    initrd = {
      verbose = false;
      systemd.enable = true;
    };

    lanzaboote = {
      enable = true;
      pkiBundle = "/etc/secureboot";
    };

    loader = {
      systemd-boot = {
        enable = lib.mkForce false;
        configurationLimit = 5;
        extraEntries = {
          "loader.conf" = ''
            default auto-efi-default
          '';
        };
      };
      efi.canTouchEfiVariables = true;

      grub = {
        enable = false;
        efiSupport = false;
        device = "nodev";
        useOSProber = true;
      };
    };
    kernelModules = [ "tcp_bbr" "kvm-amd" "netconsole" "amd-pstate" "amdgpu" ];
    kernelParams = [
      "quiet"
      "splash"
      "rd.systemd.show_status=false"
      "rd.udev.log_level=3"
      "udev.log_priority=3"
      "amd_pstate=active"
      "loglevel=3"
    ];
    extraModprobeConfig = ''
      options exclusive_caps=1 card_label="Virtual Camera"
    '';
  };

  security.polkit.enable = true;

  hardware = {
    enableAllFirmware = true;
    cpu.amd.updateMicrocode = true;
    graphics = {
      enable = true;
      extraPackages = with pkgs; [ vaapiVdpau libvdpau-va-gl ];
    };
  };

  services.hdapsd.enable = true;
  services.fstrim.enable = true;

  swapDevices = [{
    device = "/swapfile";
    size = 24 * 1024;
  }];
  services.displayManager.autoLogin = {
    enable = true;
    user = "ricardo";
  };
}
