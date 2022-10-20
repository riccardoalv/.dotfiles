{ config, pkgs, ... }:

{
  imports = [ ./configuration.nix ];

  boot = {
    initrd = {
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

  services.fprintd.enable = true;
  services.xserver.displayManager.autoLogin.user = "ricardo";

  system.autoUpgrade = {
    enable = true;
    flake = "/home/ricardo/.dotfiles#laptop";
    flags = [ "--impure" ];
    dates = "daily";
  };

  # auto-cpufreq
  services.auto-cpufreq.enable = true;
  systemd.services.auto-cpufreq.after = [ "power-profiles-daemon.service" ];
  services.thermald.enable = true;
}
