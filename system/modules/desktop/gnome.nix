{ pkgs, lib, ... }:
{
  # gsconnect
  programs.kdeconnect = {
    enable = true;
    package = pkgs.gnomeExtensions.gsconnect;
  };

  services.gvfs.enable = true;
  services.gnome.sushi.enable = true;
  services.colord.enable = true;
  programs.xwayland.enable = true;
  services.xserver = {
    enable = true;
    excludePackages = with pkgs; [ xterm ];
  };

  services.desktopManager.gnome.extraGSettingsOverrides = ''
    [org.gnome.mutter]
    experimental-features=['variable-refresh-rate']
  '';

  services.desktopManager.gnome.enable = true;
  services.displayManager = {
    gdm = {
      enable = true;
      wayland = true;
    };
  };

  services.irqbalance.enable = true;

  services.libinput.enable = true;

  environment.sessionVariables.NIXOS_OZONE_WL = "1";
  environment.sessionVariables.ELECTRON_OZONE_PLATFORM_HINT = "wayland";

  xdg = {
    portal = {
      enable = true;
      extraPortals = with pkgs; [ xdg-desktop-portal-wlr ];
    };
  };

  systemd.user.services."gnome-shell" = {
    serviceConfig = {
      Slice = "gnome-realtime.slice";
      CPUSchedulingPolicy = "rr";
      CPUSchedulingPriority = 50;
      IOSchedulingClass = "realtime";
      IOSchedulingPriority = 0;
    };
  };

  systemd.oomd = {
    enable = true;
    enableUserSlices = true;
    enableRootSlice = true;
    extraConfig = {
      RootKill = "no";
      DefaultMemoryPressureLimit = "80%";
      ManagedOOMPreferenceOverride = "gnome-realtime.slice avoid";
    };
  };

  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@tty1".enable = false;
  programs.dconf.enable = true;
  programs.gpaste.enable = true;
  services.udev.packages = with pkgs; [ gnome-settings-daemon ];
  environment.gnome.excludePackages = with pkgs; [
    gnome-tour
    gnome-user-docs
    gnome-software
    gnome-weather
    gnome-maps
    yelp
  ];

  environment.systemPackages = with pkgs; [
    smartmontools
    deja-dup
    gnome-tweaks
    nautilus-python
    adwaita-icon-theme
    gnomeExtensions.appindicator
    gnomeExtensions.tailscale-qs
  ];
  environment.sessionVariables.GST_PLUGIN_SYSTEM_PATH_1_0 =
    lib.makeSearchPathOutput "lib" "lib/gstreamer-1.0"
      (
        with pkgs.gst_all_1;
        [
          gst-plugins-good
          gst-plugins-bad
          gst-plugins-ugly
          gst-libav
        ]
      );
}
