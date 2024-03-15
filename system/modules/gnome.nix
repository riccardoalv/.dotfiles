{ config, pkgs, ... }: {
  # gsconnect
  programs.kdeconnect = {
    enable = true;
    package = pkgs.gnomeExtensions.gsconnect;
  };

  services.gvfs.enable = true;
  services.gnome.sushi.enable = true;
  services.colord.enable = true;
  services.xserver = {
    enable = true;
    desktopManager.gnome.enable = true;
    displayManager = {
      gdm = {
        enable = true;
        wayland = true;
      };
    };
    excludePackages = with pkgs; [ xterm ];
    libinput.enable = true;
  };
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@tty1".enable = false;
  programs.dconf.enable = true;
  services.udev.packages = with pkgs; [ gnome.gnome-settings-daemon ];
  services.dbus.packages = with pkgs; [ gnome2.GConf ];
  environment.gnome.excludePackages = with pkgs; [
    gnome-tour
    gnome-user-docs
    gnome.gnome-software
    gnome.gnome-weather
    gnome.gnome-maps
    gnome.yelp
  ];

  environment.systemPackages = with pkgs; [
    gnome.gnome-tweaks
    gnome.adwaita-icon-theme
    gnomeExtensions.appindicator
    gnomeExtensions.pop-shell
  ];
}
