{ config, pkgs, ... }:

{
  imports = [ ./configuration.nix ];

  system.autoUpgrade = {
    enable = true;
    flake = "/home/ricardo/.dotfiles#desktop";
    flags = [ "--impure" ];
    dates = "daily";
  };
}
