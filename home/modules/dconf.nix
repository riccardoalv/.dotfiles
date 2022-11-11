{ config, ... }:

{
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
    "org/gnome/desktop/background" = {
      color-shading-type = "solid";
      picture-options = "zoom";
      picture-uri =
        "file:///run/current-system/sw/share/backgrounds/gnome/blobs-l.svg";
      picture-uri-dark =
        "file:///run/current-system/sw/share/backgrounds/gnome/blobs-d.svg";
      primary-color = "#3465a4";
      secondary-color = "#000000";
    };
    "org/gnome/desktop/input-sources" = {
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
    };
    "org/gnome/desktop/screensaver" = {
      color-shading-type = "solid";
      picture-options = "zoom";
      picture-uri =
        "file:///run/current-system/sw/share/backgrounds/gnome/blobs-l.svg";
      primary-color = "#3465a4";
      secondary-color = "#000000";
    };
    "org/gnome/epiphany" = { ask-for-default = false; };
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
      power-saver-profile-on-low-battery = false;
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
        "code.desktop"
      ];
      had-bluetooth-devices-setup = false;
      enabled-extensions = [
        "appindicatorsupport@rgcjonas.gmail.com"
        "gsconnect@andyholmes.github.io"
        "dash-to-dock@micxgx.gmail.com"
        "blur-my-shell@aunetx"
        "extension-list@tu.berry"
      ];

    };
    "org/gnome/settings-daemon/plugins/media-keys" = {
      custom-keybindings =
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/";
    };
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" =
      {
        binding = "<Shift><Super>m";
        command = "geary";
        name = "Launch geary";
      };
    "org/gnome/terminal/legacy" = { theme-variant = "dark"; };
    "org/gnome/todo" = {
      default-provider = "local";
      style-variant = "dark";
    };
    "org/gnome/tweaks" = { show-extensions-notice = false; };
    "org/gnome/shell/extensions/blur-my-shell" = { brightness = 0.8; };
    "org/gnome/shell/extensions/blur-my-shell/appfolder" = { blur = true; };
    "org/gnome/shell/extensions/dash-to-dock" = {
      background-color = "rgb(0,0,0)";
      background-opacity = 0.3;
      show-trash = false;
      transparency-mode = "FIXED";
      show-show-apps-button = false;
      running-indicator-style = "DASHES";
    };
    "org/gnome/shell/extensions/extension-list" = {
      del-button = false;
      dis-button = false;
      ext-button = false;
      pin-button = false;
      url-button = false;
    };
  };
}
