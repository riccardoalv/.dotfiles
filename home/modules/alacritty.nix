{ config, pkgs, ... }:

{
  home.packages = with pkgs; [ ubuntu_font_family ];
  programs.alacritty = {
    enable = true;
    settings = {
      window = {
        opacity = 0.95;
        decorations_theme_variant = "dark";
      };
      scrolling.history = 50000;
      font = {
        normal = { family = "Ubuntu Mono"; };
        size = 12;
      };
      colors.primary.background = "#181A21";
    };
  };
}
