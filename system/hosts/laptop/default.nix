{ ... }:
{
  imports = [
    ./hardware.nix
    ./configuration.nix
    ./touchpad-fix.nix
    ./power.nix
  ];
}
