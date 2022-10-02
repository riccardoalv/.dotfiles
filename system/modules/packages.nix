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

  # docker
  virtualisation.docker.enable = true;
  virtualisation.docker.daemon.settings = {
    data-root = "/home/ricardo/.local/var/lib/";
  };

  # libvirtd
  virtualisation.libvirtd.enable = true;

  # gnome
  services.gvfs.enable = true;
  services.gnome.sushi.enable = true;
  services.colord.enable = true;
  services.xserver = {
    enable = true;
    desktopManager.gnome.enable = true;
    displayManager.gdm.enable = true;
    displayManager.gdm.wayland = true;
    excludePackages = (with pkgs; [ xterm ]);
  };
  programs.xwayland.enable = true;
  programs.dconf.enable = true;
  services.udev.packages = with pkgs; [ gnome.gnome-settings-daemon ];
  services.dbus.packages = with pkgs; [ gnome2.GConf ];
  environment.gnome.excludePackages = (with pkgs; [
    gnome-tour
    epiphany
    gnome-user-docs
    gnome.gnome-software
    gnome.gnome-weather
    gnome.gnome-maps
    gnome.gnome-music
  ]);

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

  # Enable CUPS to print documents.
  services.printing = {
    enable = true;
    browsing = true;
    drivers = with pkgs; [ hplip ];
  };

  # auto-cpufreq
  services.auto-cpufreq.enable = true;
  services.thermald.enable = true;
  systemd.packages = with pkgs; [ auto-cpufreq thermald ];
  programs.nix-ld.enable = true;
  environment.variables = {
    NIX_LD_LIBRARY_PATH =
      lib.makeLibraryPath [ pkgs.gcc pkgs.stdenv.cc.cc pkgs.openssl pkgs.glib ];
    NIX_LD = lib.fileContents "${pkgs.stdenv.cc}/nix-support/dynamic-linker";
  };
}
