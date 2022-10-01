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

      docker-compose
      texlive.combined.scheme-full
      asdf-vm
      gcc
      rustup
      python3
      nodejs
      ansible

      nmap

      firefox
      brave
      chromium
      discord
      spotify
      gnome.gnome-tweaks
      gnome.adwaita-icon-theme
      gnomeExtensions.appindicator
    ];

    home.stateVersion = "21.05";

    programs.home-manager.enable = true;
  };
}
