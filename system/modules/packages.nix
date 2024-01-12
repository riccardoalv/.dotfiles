{ config, pkgs, lib, ... }:

{
  environment.systemPackages = with pkgs; [
    binutils
    sqlite
    bintools
    coreutils-full
    file
    dmidecode
    wget
    curl
    killall
    virt-manager
    vim
    stow
    cifs-utils
  ];

  # pkgs Settings

  services.flatpak.enable = true;

  virtualisation = {
    docker = {
      enable = true;
      enableOnBoot = false;
    };

    libvirtd.enable = true;

    waydroid.enable = true;
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

  # Android
  programs.adb.enable = true;

  # fish
  programs.fish.enable = true;

  environment.shells = with pkgs; [ fish ];
  users.defaultUserShell = pkgs.fish;

  # Editor
  programs.neovim.defaultEditor = true;

  # Avahi
  services.avahi = {
    enable = true;
    nssmdns = true;
    publish = {
      enable = true;
      addresses = true;
      domain = true;
      hinfo = true;
      userServices = true;
      workstation = true;
    };
  };

  # Wireshark
  programs.wireshark = {
    enable = true;
    package = pkgs.wireshark-qt;
  };

  # Enable CUPS to print documents.
  services.printing = {
    enable = true;
    browsing = true;
    drivers = with pkgs; [ hplip ];
  };

  services.fwupd.enable = true;

  # Add git config for root
  programs.git = {
    enable = true;
    config = {
      user = {
        name = "root";
        email = "root@root.com";
      };
    };
  };
}
