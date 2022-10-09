{ config, pkgs, ... }: {
  imports = [
    ./modules/dev.nix
    ./modules/kitty.nix
    ./modules/tmux.nix
    ./modules/dconf.nix
  ];
  config = {
    home.packages = with pkgs; [
      neovim
      tree-sitter
      luarocks
      vscode
      xclip
      ctags
      ripgrep
      bat
      fd
      git-crypt
      stow
      nixfmt

      docker-compose
      texlive.combined.scheme-full
      asdf-vm
      gcc
      rustup
      python3
      nodejs
      ansible

      nmap
      unzip
      figlet
      yad
      gnumake

      firefox
      brave
      chromium
      discord
      spotify
      amberol
      gnome.gnome-tweaks
      gnome.adwaita-icon-theme
      gnomeExtensions.appindicator
    ];

    qt = {
      enable = true;
      style = {
        name = "adwaita-dark";
        package = pkgs.adwaita-qt;
      };
    };

    # Auto Updgrade home-manager
    systemd.user = {
      startServices = "legacy";
      timers.home-manager-auto-upgrade = {
        Unit.Description = "Home Manager upgrade timer";
        Install.WantedBy = [ "timers.target" ];
        Timer = {
          OnCalendar = "daily";
          Unit = "home-manager-auto-upgrade.service";
          Persistent = true;
        };
      };

      services.home-manager-auto-upgrade = {
        Unit.Description = "Home Manager upgrade";
        Service.ExecStart = toString
          (pkgs.writeShellScript "home-manager-auto-upgrade" ''
            nix-channel --update
            echo "Upgrade Home Manager"
            home-manager --flake /home/ricardo/.dotfiles switch
          '');
      };
    };

    home.stateVersion = "22.05";

    programs.home-manager.enable = true;
  };
}
