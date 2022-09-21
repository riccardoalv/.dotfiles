# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
    /etc/nixos/hardware-configuration.nix
    ./packages.nix
  ];

  # Use the Systemd-Boot EFI boot loader.
  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    plymouth.enable = true;
    loader = {
      efi.canTouchEfiVariables = true;
      grub = {
        enable = true;
        efiSupport = true;
        device = "nodev";
        useOSProber = true;
# enableCryptdisk = true;
        extraConfig = "set theme=/boot/grub/themes/vimix/theme.txt";
      };
    };
    kernelParams = [
      "quiet"
      "splash"
      "rd.systemd.show_status=false"
      "rd.udev.log_level=3"
      "udev.log_priority=3"
    ];
    consoleLogLevel = 0;
    initrd = {
      verbose = false;
      # luks.devices = [
      #   {
      #     name = "root";
      #     device = "/disk/by-uuid/********-****-****-****-************";
      #   };
      #   {
      #     name = "home"
      #     device = "/disk/by-uuid/********-****-****-****-************"
      #   };
      # ];
    };
  };

  services.fwupd.enable = true;

  swapDevices = [{device = "/var/swapfile"; size = 4000;}];

  # Network
  networking.usePredictableInterfaceNames = false;

  networking.hostName = "NixOs"; # Define your hostname.
  networking.networkmanager.enable = true;

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
    ];
  };

  # Enable Audio
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
  };

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Enable touchpad support
  services.xserver.libinput.enable = true;

  # Enable Auto Upgrade
  system.autoUpgrade.enable = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  system.stateVersion = "22.05";
}
