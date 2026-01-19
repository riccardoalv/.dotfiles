{ config, pkgs, ... }:

{
  programs.tmux = {
    enable = true;
    prefix = "M-w";
    mouse = false;
    clock24 = true;
    historyLimit = 60000;
    baseIndex = 0;
    keyMode = "vi";
    escapeTime = 0;
    terminal = "tmux-256color";
    resizeAmount = 5;
    aggressiveResize = false;
    disableConfirmationPrompt = false;
    extraConfig = ''

      # Set up focus events
      set-option -g focus-events on

      # Configure pane selection and Vim navigation
      bind -T copy-mode-vi v send -X begin-selection
      bind -T copy-mode-vi y send-keys -X copy-pipe-and-cancel "pbcopy"
      bind r source-file ~/.config/tmux/tmux.conf \; display "Reloaded!"
      bind o run-shell "open #{pane_current_path}"

      is_vim="ps -o state= -o comm= -t '#{pane_tty}' | grep -iqE '^[^TXZ ]+ +(\\S+\\/)?g?(view|l?n?vim?x?)(diff)?$'"
      bind-key -n 'C-h' if-shell "$is_vim" 'send-keys C-h'  'select-pane -L'
      bind-key -n 'C-j' if-shell "$is_vim" 'send-keys C-j'  'select-pane -D'
      bind-key -n 'C-k' if-shell "$is_vim" 'send-keys C-k'  'select-pane -U'
      bind-key -n 'C-l' if-shell "$is_vim" 'send-keys C-l'  'select-pane -R'
      tmux_version='$(tmux -V | sed -En "s/^tmux ([0-9]+(.[0-9]+)?).*/\1/p")'
      if-shell -b '[ "$(echo "$tmux_version < 3.0" | bc)" = 1 ]' \
          "bind-key -n 'C-\\' if-shell \"$is_vim\" 'send-keys C-\\'  'select-pane -l'"
      if-shell -b '[ "$(echo "$tmux_version >= 3.0" | bc)" = 1 ]' \
          "bind-key -n 'C-\\' if-shell \"$is_vim\" 'send-keys C-\\\\'  'select-pane -l'"

      # Copy mode vi pane selection
      bind-key -T copy-mode-vi 'C-h' select-pane -L
      bind-key -T copy-mode-vi 'C-j' select-pane -D
      bind-key -T copy-mode-vi 'C-k' select-pane -U
      bind-key -T copy-mode-vi 'C-l' select-pane -R
      bind-key -T copy-mode-vi 'C-\' select-pane -l

      bind-key -r -T prefix       M-Up              resize-pane -U 5
      bind-key -r -T prefix       M-Down            resize-pane -D 5
      bind-key -r -T prefix       M-Left            resize-pane -L 5
      bind-key -r -T prefix       M-Right           resize-pane -R 5

      # Status bar configuration
      set -g status on
      set -g status-justify left
      # set -g status-fg cyan
      # set -g status-bg black
      set -g set-titles on
      set -g set-titles-string "#T"

      set -g repeat-time 0
      set -g display-time 4000
    '';

    plugins = with pkgs; [
      tmuxPlugins.sensible
      { plugin = pkgs.tmuxPlugins.resurrect; }
      {
        plugin = pkgs.tmuxPlugins.continuum;
        extraConfig = ''
          set -g @continuum-restore "on"
        '';
      }
      tmuxPlugins.yank
      {
        plugin = pkgs.tmuxPlugins.dracula;
        extraConfig = ''
          set -g @dracula-show-flags true
          set -g @dracula-cpu-usage-colors "pink dark_gray"
          set -g @dracula-show-left-sep " "
          set -g @dracula-show-right-sep " "

          set -g @dracula-show-left-icon " "
          set -g @dracula-show-powerline true
          set -g @dracula-plugins "git"

          set -g @dracula-colors "
          white='#f8f8f2'
          gray='#1c1c1c'
          dark_gray='#000000'
          light_purple='#bd93f9'
          dark_purple='#38383B'
          cyan='#8be9fd'
          green='#383838'
          orange='#ffb86c'
          red='#ff5555'
          pink='#ff79c6'
          yellow='#383838'
          "
        '';
      }
    ];
  };
}
