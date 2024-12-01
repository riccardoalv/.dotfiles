{ config, pkgs, lib, unstable, ... }: {
  imports = [ ./modules/dconf.nix ./modules/tmux.nix ];
  config = {
    home.packages = with pkgs;
      [
        alacritty
        obs-studio
        # Web
        distrobox
        fragments
        docker-compose
        gparted
        wine
        qmk

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

        # Utils
        scrcpy
        nmap
        eyedropper
        (nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" "UbuntuMono" ]; })
        obsidian
        google-chrome
        vesktop
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
      linkLazyGit = ''
        mkdir -p $HOME/.config/lazygit/
        ln -s -v -f \
        $HOME/.dotfiles/dotfiles/config.yml $HOME/.config/lazygit/
      '';
      linkAlacritty = ''
        mkdir -p $HOME/.config/alacritty/
        ln -s -v -f \
        $HOME/.dotfiles/dotfiles/alacritty.yml $HOME/.config/alacritty/
      '';
    };

    systemd.user.services = {
      backup = {
        Unit = {
          Description = "Mount Backup using gio";
          After = ["network.target"];
          Wants = ["network-online.target"];
        };
        Service = {
          Restart = "on-failure";
          Type = "oneshot";
          PassEnvironment = "DISPLAY";
          ExecStart = "/run/current-system/sw/bin/gio mount smb://ubuntu-server/Backups/";
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
          WantedBy = ["timers.target"];
        };
      };
    };

    systemd.user.tmpfiles.rules = [
      "d %h/TEMP 0755 - - 7d"
    ];

    programs.neovim = {
      enable = true;
      defaultEditor = true;
      withNodeJs = true;
      withPython3 = true;
      withRuby = true;
      extraPackages = with pkgs; [
        lua-language-server
        nil
        nixfmt-classic
        stylua
        clang
        gcc
        gnumake
        typescript-language-server
        ruff
        prettierd
        eslint
      ];
    };

    services.easyeffects.enable = true;

    gtk.theme.name = "Adawaita";

    programs.firefox.enable = true;

    programs.starship.enable = true;

    home.stateVersion = "24.11";

    programs.home-manager.enable = true;
  };
}
