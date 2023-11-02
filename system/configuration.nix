{ config, pkgs, ... }:

{
  imports =
    [ ./modules/packages.nix ./modules/network.nix ./modules/gnome.nix ];

  boot = {
    kernel.sysctl = {
      "vm.vfs_cache_pressure" = 50;
      "vm.swappiness" = 10;
    };
    plymouth.enable = true;
    loader = {
      efi.canTouchEfiVariables = true;
      grub = {
        enable = true;
        efiSupport = true;
        device = "nodev";
        useOSProber = true;
      };
    };
    kernelParams = [
      "quiet"
      "splash"
      "rd.systemd.show_status=false"
      "rd.udev.log_level=3"
      "udev.log_priority=3"
    ];
  };

  # Set your time zone.
  time.timeZone = "America/Porto_Velho";

  # Define a user account
  users.users.ricardo = {
    isNormalUser = true;
    home = "/home/ricardo";
    description = "Ricardo";
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
