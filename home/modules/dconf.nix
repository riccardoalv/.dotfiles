{ config, lib, ... }:

with lib.hm.gvariant;
{
  dconf.settings = {
    "org/gnome/desktop/input-sources" = {
      sources = [
        (mkTuple [
          "xkb"
          "us"
        ])
        (mkTuple [
          "xkb"
          "br"
        ])
      ];
      xkb-options = [
        "ctrl:swapcaps"
        "fkeys:basic_13-24"
        "shift:both_capslock"
        "scrolllock:mod3"
      ];
    };
    "org/gnome/desktop/interface" = {
      clock-show-weekday = true;
      show-battery-percentage = true;
      color-scheme = "prefer-dark";
      font-antialiasing = "grayscale";
      font-hinting = "slight";
      gtk-theme = "HighContrastInverse";
      monospace-font-name = "UbuntuMono Nerd Font 12";
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
    "org/gnome/settings-daemon/plugins/power" = {
      power-button-action = "suspend";
      power-saver-profile-on-low-battery = true;
    };
    "org/gnome/shell" = {
      disable-user-extensions = false;
      favorite-apps = [
        "Alacritty.desktop"
        "org.gnome.Nautilus.desktop"
        "google-chrome.desktop"
        "com.spotify.Client.desktop"
        "org.gnome.Geary.desktop"
        "obsidian.desktop"
      ];
      enabled-extensions = [
        "appindicatorsupport@rgcjonas.gmail.com"
        "gsconnect@andyholmes.github.io"
        "GPaste@gnome-shell-extensions.gnome.org"
        "tailscale@joaophi.github.com"
      ];
    };
    "org/gnome/tweaks" = {
      show-extensions-notice = false;
    };
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
      switch-applications = [ ];
      switch-applications-backward = [ ];
      cycle-windows = [ "<Alt>Tab" ];
      cycle-windows-backward = [ "<Shift><Alt>Tab" ];
    };
    "org/gnome/settings-daemon/plugins/media-keys" = {
      logout = [ ];
      next = [ "<Alt><Super>Right" ];
      play = [ "Pause" ];
      previous = [ "<Alt><Super>Left" ];
    };
    "org/gnome/deja-dup" = {
      backend = "remote";
      delete-after = 0;
      periodic = true;
      periodic-period = 1;
      exclude-list = [
        "$TRASH"
        "/home/ricardo/.android"
        "/home/ricardo/.arduino15"
        "/home/ricardo/.conda"
        "/home/ricardo/.cups"
        "/home/ricardo/.docker"
        "/home/ricardo/.expo"
        "/home/ricardo/.gnupg"
        "/home/ricardo/.ipython"
        "/home/ricardo/.java"
        "/home/ricardo/.jssc"
        "/home/ricardo/.minecraft"
        "/home/ricardo/.mozilla"
        "/home/ricardo/.nix-defexpr"
        "/home/ricardo/.nix-profile"
        "/home/ricardo/.npm"
        "/home/ricardo/.tlauncher"
        "/home/ricardo/.yarn"
        "/home/ricardo/Android"
        "/home/ricardo/Arduino"
        "/home/ricardo/Documents/ISOs"
        "/home/ricardo/Downloads"
      ];
    };
    "org/gnome/deja-dup/remote" = {
      folder = "NixOS-Laptop";
      uri = "smb://192.168.1.51/Backups";
    };
  };
}
