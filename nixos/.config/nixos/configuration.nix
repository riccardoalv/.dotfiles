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
  boot.loader.systemd-boot.enable = true;

  boot.plymouth.enable = true;

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
    ];
  };

  # Enable Audio
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
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

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable Auto Upgrade
  system.autoUpgrade.enable = true;

  system.stateVersion = "22.05";
}

