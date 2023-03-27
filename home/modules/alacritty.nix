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
          background = "#1e2127";
          foreground = "#abb2bf";
          bright_foreground = "#ffffff";
        };
        bright = {
          black   = "#5c6370";
          red     = "#e06c75";
          green   = "#98c379";
          yellow  = "#d19a66";
          blue    = "#61afef";
          magenta = "#c678dd";
          cyan    = "#56b6c2";
          white   = "#e6efff";
        }
        dim = {
          black   = "#1e2127"
          red     = "#e06c75"
          green   = "#98c379"
          yellow  = "#d19a66"
          blue    = "#61afef"
          magenta = "#c678dd"
          cyan    = "#56b6c2"
          white   = "#828791"
        }
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
          black = "#1e2127";
          red = "#e06c75";
          green = "#98c379";
          yellow = "#d19a66";
          blue = "#61afef";
          magenta = "#c678dd";
          cyan = "#65b6c2";
          white = "#f8f8f2";
        };
      };
    };
  };
}
