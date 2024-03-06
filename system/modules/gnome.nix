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
      autoLogin = {
        enable = true;
        user = "ricardo";
      };
    };
    excludePackages = with pkgs; [ xterm ];
    libinput.enable = true;
  };
  programs.xwayland.enable = true;
  programs.dconf.enable = true;
  services.udev.packages = with pkgs; [ gnome.gnome-settings-daemon ];
  services.dbus.packages = with pkgs; [ gnome2.GConf ];
  environment.gnome.excludePackages = with pkgs; [
    gnome-tour
    gnome-user-docs
    gnome.gnome-software
    gnome.gnome-weather
    gnome.gnome-maps
  ];

  environment.systemPackages = with pkgs; [
    gnome.gnome-tweaks
    gnome.adwaita-icon-theme
    gnomeExtensions.appindicator
    gnomeExtensions.pop-shell
  ];
}
