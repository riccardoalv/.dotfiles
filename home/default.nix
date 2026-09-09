{ pkgs, stable, ... }:
{
  imports = [
    ./modules/dconf.nix
    ./modules/tmux.nix
  ];
  config = {
    home.packages = [
      pkgs.alacritty

      # Web
      pkgs.distrobox
      pkgs.fragments
      pkgs.docker-compose
      pkgs.gparted

      # Terminal apps
      pkgs.tmux
      pkgs.atuin
      pkgs.fzf
      pkgs.ripgrep
      pkgs.zoxide
      pkgs.lazygit
      pkgs.tokei
      pkgs.bat
      pkgs.delta
      pkgs.vscode
      pkgs.fd
      pkgs.yq
      pkgs.jq
      pkgs.entr
      pkgs.gh
      pkgs.xclip
      pkgs.wl-clipboard
      pkgs.appimage-run
      pkgs.eza
      pkgs.gping
      pkgs.difftastic
      pkgs.dblab
      pkgs.postgresql

      # Utils
      pkgs.scrcpy
      pkgs.nmap
      pkgs.eyedropper
      pkgs.obsidian
      pkgs.google-chrome
      pkgs.vesktop
      pkgs.crosspipe
      pkgs.slack
      pkgs.packet
      pkgs.android-tools

      stable.easyeffects

      (pkgs.spotify.overrideAttrs (oldAttrs: {
        postInstall = (oldAttrs.postInstall or "") + ''
          wrapProgram $out/bin/spotify \
            --unset NIXOS_OZONE_WL \
            --unset ELECTRON_OZONE_PLATFORM_HINT \
            --set WAYLAND_DISPLAY ""
        '';
      }))
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
      sideloadInitLua = true;
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

    gtk.theme.name = "Adwaita";

    programs.firefox.enable = true;

    programs.starship.enable = true;

    home.stateVersion = "26.05";

    systemd.user.services.input-remapper-autoload = {
      Unit = {
        Description = "Input-Remapper Autoload Presets";
        After = [ "graphical-session.target" ];
      };
      Service = {
        Type = "oneshot";
        ExecStart = "${pkgs.input-remapper}/bin/input-remapper-control --command autoload";
        RemainAfterExit = true;
      };
      Install = {
        WantedBy = [ "default.target" ];
      };
    };

    programs.home-manager.enable = true;
  };
}
