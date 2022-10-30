{ config, pkgs, ... }: {
  imports = [
    ./modules/dev.nix
    ./modules/alacritty.nix
    ./modules/tmux.nix
    ./modules/dconf.nix
    ./modules/dotfiles.nix
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

      gcc
      rustup
      python3
      nodejs
      distrobox

      nmap
      unzip
      figlet

      obs-studio
      firefox
      brave
      chromium
      discord
      spotify
      amberol
      fragments
      authenticator
    ];

    qt = {
      enable = true;
      style = {
        name = "adwaita-dark";
        package = pkgs.adwaita-qt;
      };
    };

    home.stateVersion = "22.05";

    programs.home-manager.enable = true;
  };
}
