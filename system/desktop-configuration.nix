{ config, pkgs, ... }:

{
  imports = [ ./configuration.nix ];

  system.autoUpgrade = {
    enable = true;
    flake = "/home/ricardo/.dotfiles#desktop";
    flags = [ "--commit-lock-file" "--impure" ];
    dates = "daily";
  };
}
