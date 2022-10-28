{ config, pkgs, lib, ... }:

{
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    binutils
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

  # flatpak
  services.flatpak.enable = true;

  virtualisation = {
    # docker
    docker = {
      enable = true;
      enableOnBoot = false;
      daemon.settings = { data-root = "/home/ricardo/.local/var/lib/"; };
    };

    # libvirtd
    libvirtd.enable = true;
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

  # zsh
  programs.zsh.enable = true;

  environment.shells = with pkgs; [ zsh ];
  users.defaultUserShell = pkgs.zsh;

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

  # nix-ld
  programs.nix-ld.enable = true;
  environment.variables = {
    NIX_LD_LIBRARY_PATH =
      lib.makeLibraryPath [ pkgs.gcc pkgs.stdenv.cc.cc pkgs.openssl pkgs.glib ];
    NIX_LD = pkgs.binutils.dynamicLinker;
  };
}
