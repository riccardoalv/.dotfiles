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

    home.stateVersion = "21.05";

    qt = {
      enable = true;
      style = {
        name = "adwaita-dark";
        package = pkgs.adwaita-qt;
      };
      platformTheme = "gnome";
    };

    programs.home-manager.enable = true;
  };
}
