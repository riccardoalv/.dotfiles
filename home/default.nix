{ pkgs, stable, ... }:
{
  imports = [
    ./modules/dconf.nix
    ./modules/tmux.nix
  ];
  config = {
    home.packages = [
      pkgs.distrobox
      pkgs.fragments
      pkgs.docker-compose
      pkgs.gparted
      pkgs.google-chrome
      pkgs.alacritty
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
      (pkgs.appimage-run.override {
        # bibliotecas extras para AppImages que usam WebKitGTK (ex.: Anycubic Slicer Next)
        extraPkgs =
          p: with p; [
            webkitgtk_4_1
            libsoup_3
            glib-networking
            libtiff
            gst_all_1.gstreamer
            gst_all_1.gst-plugins-base
            gst_all_1.gst-plugins-good
            gst_all_1.gst-libav
            # AppRun da Anycubic força __EGL_VENDOR_LIBRARY_FILENAMES=/usr/share/glvnd/egl_vendor.d/50_mesa.json
            mesa
          ];
      })
      pkgs.eza
      pkgs.gping
      pkgs.difftastic
      pkgs.dblab
      pkgs.postgresql
      pkgs.claude-code
      pkgs.android-tools
      pkgs.codex
      pkgs.gcc
      pkgs.scrcpy
      pkgs.eyedropper
      pkgs.obsidian
      pkgs.vesktop
      pkgs.crosspipe
      pkgs.slack
      pkgs.packet
      pkgs.orca-slicer
      pkgs.octaveFull
      pkgs.uv
      pkgs.ansible

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

    home.pointerCursor = {
      enable = true;
      gtk.enable = true;
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Classic";
      size = 24;
    };

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
      linkHypr = ''
        ln -s -v -f -n \
        $HOME/.dotfiles/dotfiles/hypr $HOME/.config/
      '';
      linkWaybar = ''
        ln -s -v -f -n \
        $HOME/.dotfiles/dotfiles/waybar $HOME/.config/
      '';
      linkMako = ''
        ln -s -v -f -n \
        $HOME/.dotfiles/dotfiles/mako $HOME/.config/
      '';
      linkWofi = ''
        ln -s -v -f -n \
        $HOME/.dotfiles/dotfiles/wofi $HOME/.config/
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
        tree-sitter
      ];
    };

    gtk.theme.name = "Adwaita";

    programs.firefox.enable = true;

    programs.starship.enable = true;

    home.stateVersion = "26.05";

    programs.home-manager.enable = true;
  };
}
