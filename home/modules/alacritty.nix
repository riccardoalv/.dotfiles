{ config, pkgs, ... }:

{
  home.packages = with pkgs; [ ubuntu_font_family ];
  programs.alacritty = {
    enable = true;
    settings = {
      window = {
        opacity = 0.5;
        decorations_theme_variant = "dark";
      };
      scrolling.history = 50000;
      font = {
        normal = { family = "Ubuntu Mono"; };
        size = 12;
      };
      key_bindings = [
        {
          key = "N";
          mods = "Control|Shift";
          action = "SpawnNewInstance";
        }
        {
          key = "W";
          mods = "Control|Shift";
          action = "Quit";
        }
        {
          key = "F";
          mods = "Control|Shift";
          action = "ToggleFullscreen";
        }
      ];
      colors = {
        primary = {
          background = "#181A21";
          foreground = "#f8f8f2";
          bright_foreground = "#ffffff";
        };
        search = {
          matches = {
            foreground = "#44475a";
            background = "#50fa7b";
          };
          focused_match = {
            foreground = "#44475a";
            background = "#ffb86c";
          };
        };
        footer_bar = {
          background = "#282a36";
          foreground = "#f8f8f2";
        };
        hints = {
          start = {
            foreground = "#282a36";
            background = "#f1fa8c";
          };
          end = {
            foreground = "#f1fa8c";
            background = "#282a36";
          };
        };
        selection.background = "#44475a";
        normal = {
          black = "#21222c";
          red = "#ff5555";
          green = "#50fa7b";
          yellow = "#f1fa8c";
          blue = "#bd93f9";
          magenta = "#ff79c6";
          cyan = "#8be9fd";
          white = "#f8f8f2";
        };
      };
    };
  };
}
