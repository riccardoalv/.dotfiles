{ config, pkgs, ... }:

{
  programs.kitty = {
    enable = true;
    font = {
      name = "Ubuntu Mono";
      size = 13;
      package = pkgs.ubuntu_font_family;
    };
    keybindings = {
      "alt+]" = "next_window";
      "alt+[" = "previous_window";
      "alt+up" = "resize_window taller";
      "alt+left" = "resize_window wider";
      "alt+down" = "resize_window shorter 3";
      "alt+right" = "resize_window narrower";
      "kitty_mod+j" = "launch --location=hsplit --cwd current";
      "kitty_mod+l" = "launch --location=vsplit --cwd current";
      "kitty_mod+t" = "new_tab_with_cwd";
      "kitty_mod+r" = "layout_action rotate";
      "alt+shift+]" = "next_tab";
      "alt+shift+[" = "previous_tab";
      "kitty_mod+up" = "set_background_opacity +0.1";
      "kitty_mod+down" = "set_background_opacity -0.1";
      "kitty_mod+equal" = "change_font_size all +1.0";
      "kitty_mod+minus" = "change_font_size all -1.0";
      "kitty_mod+page_up" = "scroll_line_up";
      "kitty_mod+page_down" = "scroll_line_down";
    };
    settings = {
      bold_font = "auto";
      italic_font = "auto";
      bold_italic_font = "auto";

      allow_remote_control = true;
      enabled_layouts = "splits";
      linux_display_server = "x11";
      enable_audio_bell = false;
      remember_window_size = true;
      listen_on = "unix:/tmp/mykitty";

      background = "#181A21";
      background_opacity = "0.9";
      dynamic_background_opacity = true;
      active_border_color = "#2C4D6C";
      tab_bar_background = "#101014";
      cursor_blink_interval = 0;
      tab_bar_style = "powerline";
      tab_fade = 1;
      active_tab_foreground = "#171B20";
      active_tab_background = "#6495ED";
      inactive_tab_foreground = "#787c99";
      inactive_tab_background = "#171B20";
    };
  };
}
