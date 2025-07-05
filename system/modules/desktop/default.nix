{ config, pkgs, ... }:

{
  imports = [
    ./audio.nix
    ./gnome.nix
  ];
}
