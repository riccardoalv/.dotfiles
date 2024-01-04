{ config, pkgs, lib, ... }:

{
  nixpkgs.config.allowUnfree = true;
  imports = [ ./configuration.nix ];

  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
    setLdLibraryPath = true;
  };

  services.fprintd.enable = true;

  system.autoUpgrade = {
    enable = true;
    flake = "/home/ricardo/.dotfiles#laptop";
    flags = [
      "--update-input"
      "nixpkgs"
      "--update-input"
      "nixpkgs-unstable"
      "--impure"
    ];
    dates = "daily";
  };
  swapDevices = [{
    device = "/var/lib/swapfile";
    size = 2 * 1024;
  }];

  # auto-cpufreq
  services.auto-cpufreq.enable = true;
  systemd.services.auto-cpufreq.after = [ "power-profiles-daemon.service" ];
  services.thermald.enable = true;
}
