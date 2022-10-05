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

  # gsconnect
  programs.kdeconnect = {
    enable = true;
    package = pkgs.gnomeExtensions.gsconnect;
  };

  # docker
  virtualisation.docker = {
    enable = true;
    enableOnBoot = false;
    daemon.settings = { data-root = "/home/ricardo/.local/var/lib/"; };
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
    libinput.enable = true;
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

  # nix-ld
  programs.nix-ld.enable = true;
  environment.variables = {
    NIX_LD_LIBRARY_PATH =
      lib.makeLibraryPath [ pkgs.gcc pkgs.stdenv.cc.cc pkgs.openssl pkgs.glib ];
    NIX_LD = lib.fileContents "${pkgs.stdenv.cc}/nix-support/dynamic-linker";
  };
}
