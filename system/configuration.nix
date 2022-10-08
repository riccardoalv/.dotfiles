# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports = [ ./modules/packages.nix ./modules/network.nix ];
  # Set your time zone.
  time.timeZone = "America/Porto_Velho";

  # Define a user account
  users.users.ricardo = {
    isNormalUser = true;
    home = "/home/ricardo";
    description = "Ricardo Alves da Silva";
    extraGroups = [
      "wheel"
      "networkmanager"
      "docker"
      "libvirtd"
      "flatpak"
      "qemu-libvirtd"
      "kvm"
      "adbusers"
      "input"
      "video"
      "audio"
      "colord"
    ];
  };

  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    auto-optimise-store = true;
  };

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 4d";
  };

  system.stateVersion = "22.05";
}
