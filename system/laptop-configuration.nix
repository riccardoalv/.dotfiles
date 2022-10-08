{ config, pkgs, ... }:

{
  imports = [ ./configuration.nix ];

  # Use the Systemd-Boot EFI boot loader.
  boot = {
    kernel.sysctl = { "vm.vfs_cache_pressure" = 50; };
    kernelPackages = pkgs.linuxPackages_latest;
    plymouth.enable = true;
    loader = {
      efi.canTouchEfiVariables = true;
      grub = {
        enable = true;
        efiSupport = true;
        device = "nodev";
        useOSProber = true;
        enableCryptdisk = true;
      };
    };
    kernelParams = [
      "quiet"
      "splash"
      "rd.systemd.show_status=false"
      "rd.udev.log_level=3"
      "udev.log_priority=3"
    ];
    consoleLogLevel = 0;
    initrd = {
      verbose = false;
      luks.devices = [
        {
          name = "root";
          device = "/disk/by-uuid/********-****-****-****-************";
        }
        {
          name = "home";
          device = "/disk/by-uuid/********-****-****-****-************";
        }
      ];
    };
  };

  system.autoUpgrade = {
    enable = true;
    flake = "/home/ricardo/.dotfiles#laptop";
    dates = "daily";
  };

  # auto-cpufreq
  services.auto-cpufreq.enable = true;
  systemd.services.auto-cpufreq.after = [ "power-profiles-daemon.service" ];
  services.thermald.enable = true;
}
