{ config, pkgs, ... }:

{
  programs.tmux = {
    enable = true;
    escapeTime = 0;
    keyMode = "vi";
    prefix = "M-w";
    plugins = with pkgs; [
      {
        plugin = tmuxPlugins.continuum;
        extraConfig = "set -g @continuum-restore 'on'";
      }
      {
        plugin = tmuxPlugins.resurrect;
        extraConfig = "set -g @resurrect-strategy-nvim 'session'";
      }
    ];
    extraConfig = ''
      unbind C-b
      set-option -g focus-events on

      bind -T copy-mode-vi v send -X begin-selection
      bind -T copy-mode-vi y send-keys -X copy-pipe-and-cancel "pbcopy"
      bind -T copy-mode-vi MouseDragEnd1Pane send-keys -X copy-pipe-and-cancel "pbcopy"
      bind j split-window -v
      bind l split-window -h

      bind r source-file ~/.config/tmux/tmux.conf \; display "Reloaded!"
      bind o run-shell "open #{pane_current_path}"

      bind -n C-k select-pane -U
      bind -n C-j select-pane -D
      bind -n C-h select-pane -L
      bind -n C-l select-pane -R

      set -g repeat-time 0
      set -g status-interval 0

      set -g display-time 4000
      set-option -g status-justify "left"
      set-window-option -g mode-keys vi
      set-option -g status-fg cyan
      set-option -g status-bg black
      set-option -g history-limit 60000
      set -g mouse on
      set -g set-titles on
      set -g set-titles-string "#T"

      onedark_black="#282c34"
      onedark_blue="#61afef"
      onedark_yellow="#e5c07b"
      onedark_red="#e06c75"
      onedark_white="#aab2bf"
      onedark_visual_grey="#3e4452"
      onedark_comment_grey="#5c6370"

      set -g "status" "on"
      set -g "status-justify" "left"

      set -g pane-active-border-style bg=default,fg=$onedark_blue
      set -g pane-border-style fg=$onedark_black

      set -g "status-left-length" "100"
      set -g "status-right-length" "100"

      set -g "window-style" "fg=$onedark_comment_grey"
      set -g "window-active-style" "fg=$onedark_white"

      set -g "display-panes-active-colour" "$onedark_yellow"
      set -g "display-panes-colour" "$onedark_blue"

      set -g "status-bg" "$onedark_black"
      set -g "status-fg" "$onedark_white"

      set -g "@prefix_highlight_fg" "$onedark_black"
      set -g "@prefix_highlight_bg" "$onedark_blue"
      set -g "@prefix_highlight_copy_mode_attr" "fg=$onedark_black,bg=$onedark_blue"
      set -g "@prefix_highlight_output_prefix" "  "

      set -g "status-right" "#[fg=$onedark_blue,bg=$onedark_black,nobold,nounderscore,noitalics]#[fg=$onedark_black,bg=$onedark_blue,bold] #h #[fg=$onedark_yellow, bg=$onedark_blue]"
      set -g "status-left" "#[fg=$onedark_black,bg=$onedark_blue,bold] #S #{prefix_highlight}#[fg=$onedark_blue,bg=$onedark_black,nobold,nounderscore,noitalics]"

      set -g "window-status-format" "#[fg=$onedark_black,bg=$onedark_black,nobold,nounderscore,noitalics]#[fg=$onedark_white,bg=$onedark_black] #I  #W #[fg=$onedark_black,bg=$onedark_black,nobold,nounderscore,noitalics]"
      set -g "window-status-current-format" "#[fg=$onedark_black,bg=$onedark_visual_grey,nobold,nounderscore,noitalics]#[fg=$onedark_white,bg=$onedark_visual_grey,nobold] #I  #W #[fg=$onedark_visual_grey,bg=$onedark_black,nobold,nounderscore,noitalics]"
    '';
  };
}
