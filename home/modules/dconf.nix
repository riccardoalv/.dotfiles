{ config, lib, ... }:

with lib.hm.gvariant; {
  dconf.settings = {
    "org/gnome/Geary" = { startup-notifications = true; };
    "org/gnome/desktop/app-folders/folders/Utilities" = {
      apps = [
        "gnome-abrt.desktop"
        "gnome-system-log.desktop"
        "nm-connection-editor.desktop"
        "org.gnome.baobab.desktop"
        "org.gnome.Connections.desktop"
        "org.gnome.DejaDup.desktop"
        "org.gnome.Dictionary.desktop"
        "org.gnome.DiskUtility.desktop"
        "org.gnome.eog.desktop"
        "org.gnome.Evince.desktop"
        "org.gnome.FileRoller.desktop"
        "org.gnome.fonts.desktop"
        "org.gnome.seahorse.Application.desktop"
        "org.gnome.tweaks.desktop"
        "org.gnome.Usage.desktop"
        "vinagre.desktop"
        "org.gnome.Todo.desktop"
      ];
      categories = [ "X-GNOME-Utilities" ];
      name = "X-GNOME-Utilities.directory";
      translate = true;
    };
    "org/gnome/desktop/input-sources" = {
      sources = [ (mkTuple [ "xkb" "us" ]) (mkTuple [ "xkb" "br" ]) ];
      xkb-options = [ "caps:swapescape" ];
    };
    "org/gnome/desktop/interface" = {
      clock-show-weekday = true;
      show-battery-percentage = true;
      color-scheme = "prefer-dark";
      font-antialiasing = "grayscale";
      font-hinting = "slight";
      gtk-theme = "Adwaita-dark";
    };
    "org/gnome/desktop/peripherals/touchpad" = {
      two-finger-scrolling-enabled = true;
      click-method = "areas";
      tap-to-click = true;
    };
    "org/gnome/mutter" = {
      dynamic-workspaces = true;
      workspaces-only-on-primary = true;
      attach-modal-dialogs = true;
      center-new-windows = true;
    };
    "org/gnome/nautilus/icon-view" = { default-zoom-level = "standard"; };
    "org/gnome/nautilus/preferences" = {
      default-folder-viewer = "icon-view";
      search-filter-time-type = "last_modified";
      search-view = "list-view";
    };
    "org/gnome/settings-daemon/plugins/power" = {
      idle-dim = false;
      power-button-action = "suspend";
      power-saver-profile-on-low-battery = true;
      sleep-inactive-ac-type = "nothing";
      sleep-inactive-battery-type = "nothing";
    };
    "org/gnome/shell" = {
      disable-user-extensions = false;
      favorite-apps = [
        "Alacritty.desktop"
        "org.gnome.Nautilus.desktop"
        "google-chrome.desktop"
        "spotify.desktop"
        "org.gnome.Geary.desktop"
        "obsidian.desktop"
      ];
      enabled-extensions = [
        "appindicatorsupport@rgcjonas.gmail.com"
        "gsconnect@andyholmes.github.io"
        "pop-shell@system76.com"
      ];
    };
    "org/gnome/shell/extensions/pop-shell" = {
      gap-inner = 2;
      gap-outer = 4;
      smart-gaps = true;
      tile-by-default = false;
    };
    "org/gnome/todo" = {
      default-provider = "local";
      style-variant = "dark";
    };
    "org/gnome/tweaks" = { show-extensions-notice = false; };
    "org/gnome/shell/extensions/extension-list" = {
      del-button = false;
      dis-button = false;
      ext-button = false;
      pin-button = false;
      url-button = false;
    };
    "org/gnome/desktop/wm/keybindings" = {
      move-to-workspace-left = [ "<Shift><Control><Alt>h" ];
      move-to-workspace-right = [ "<Shift><Control><Alt>l" ];
      switch-to-workspace-left = [ "<Control><Alt>h" ];
      switch-to-workspace-right = [ "<Control><Alt>l" ];
    };
  };
}
