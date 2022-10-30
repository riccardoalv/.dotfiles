{ config, pkgs, ... }:

{
  imports = [ ./configuration.nix ];

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

  # auto-cpufreq
  services.auto-cpufreq.enable = true;
  systemd.services.auto-cpufreq.after = [ "power-profiles-daemon.service" ];
  services.thermald.enable = true;
}
