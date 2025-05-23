{ config, pkgs, ... }:

{
  imports =
    [ ./modules/packages.nix ./modules/network.nix ./modules/gnome.nix ];

  # Set your time zone.
  time.timeZone = "America/Porto_Velho";

  # Define a user account
  users.users.ricardo = {
    isNormalUser = true;
    home = "/home/ricardo";
    description = "Ricardo";
    extraGroups = [
      "wheel"
      "wireshark"
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
      "rtkit"
      "colord"
    ];
  };

  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    auto-optimise-store = true;
  };

  environment.sessionVariables.EDITOR = "nvim";
  environment.sessionVariables.VISUAL = "nvim";

  system.stateVersion = "24.11";
}
