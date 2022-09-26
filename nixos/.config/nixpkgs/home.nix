{ config, pkgs, ... }:

{
  imports = [
    ./tmux.nix
    ./kitty.nix
    ./dconf.nix
    ./dev.nix
  ];

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "ricardo";
  home.homeDirectory = "/home/ricardo";

  home.packages = with pkgs; [
    vim
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
  ];

  services.kdeconnect.enable = true;

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "22.05";

  services.home-manager.autoUpgrade = {
    enable = true;
    frequency = "weekly";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
