{ pkgs, ... }:
{
  imports = [
    ./modules/dconf.nix
    ./modules/tmux.nix
  ];
  config = {
    home.packages = with pkgs; [
      alacritty
      # Web
      distrobox
      fragments
      docker-compose
      gparted

      # Terminal apps
      tmux
      atuin
      fzf
      ripgrep
      zoxide
      lazygit
      tokei
      bat
      delta
      vscode
      fd
      yq
      jq
      stow
      entr
      gh
      xclip
      wl-clipboard
      appimage-run
      eza
      fd
      gping
      difftastic
      dblab

      # Utils
      scrcpy
      nmap
      eyedropper
      obsidian
      google-chrome
      vesktop
      helvum
      slack
      packet
    ];

    qt = {
      enable = true;
      style = {
        name = "adwaita-dark";
        package = pkgs.adwaita-qt;
      };
    };

    home.activation = {
      linkFishDir = ''
        ln -s -v -f \
        $HOME/.dotfiles/fish $HOME/.config/
      '';
      linkNeovimDir = ''
        ln -s -v -f \
        $HOME/.dotfiles/nvim $HOME/.config/
      '';
      linkGitConfig = ''
        ln -s -v -f \
        $HOME/.dotfiles/dotfiles/gitconfig $HOME/.gitconfig
      '';
      linkStarship = ''
        ln -s -v -f \
        $HOME/.dotfiles/dotfiles/starship.toml $HOME/.config/
      '';
      linkAlacritty = ''
        mkdir -p $HOME/.config/alacritty/
        ln -s -v -f \
        $HOME/.dotfiles/dotfiles/alacritty.toml $HOME/.config/alacritty/
      '';
    };

    systemd.user.services = {
      backup = {
        Unit = {
          Description = "Mount Backup using gio";
          After = [ "network.target" ];
          Wants = [ "network-online.target" ];
        };
        Service = {
          Restart = "on-failure";
          Type = "oneshot";
          PassEnvironment = "DISPLAY";
          ExecStart = "/run/current-system/sw/bin/gio mount smb://192.168.1.10/Backups/";
        };
        Install = {
          WantedBy = [ "default.target" ];
        };
      };

      organizer = {
        Unit = {
          Description = "Automatic organize Downloads dir";
        };
        Service = {
          Type = "simple";
          ExecStart = "%h/organizer.sh";
        };
      };
    };

    systemd.user.timers = {
      organizer = {
        Unit = {
          Description = "Schedule Automatic organization of Downloads dir";
        };
        Timer = {
          OnCalendar = "monthly";
          Persistent = true;
        };
        Install = {
          WantedBy = [ "timers.target" ];
        };
      };
    };

    systemd.user.tmpfiles.rules = [ "d %h/TEMP 0755 - - 7d" ];

    programs.neovim = {
      enable = true;
      defaultEditor = true;
      withNodeJs = true;
      withPython3 = true;
      withRuby = true;
      extraPackages = with pkgs; [
        lua-language-server
        nil
        nixfmt
        stylua
        clang
        gcc
        gnumake
        vtsls
        ruff
        prettierd
        eslint_d
        matlab-language-server
        basedpyright
      ];
    };

    gtk.theme.name = "Adawaita";

    programs.firefox.enable = true;

    programs.starship.enable = true;

    home.stateVersion = "25.05";

    programs.home-manager.enable = true;
  };
}
