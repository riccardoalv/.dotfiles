{ config, pkgs, ... }:

{
  imports = [
    ./tmux.nix
    ./kitty.nix
    ./dconf.nix
  ];

  nixpkgs.overlays = [
    (import (builtins.fetchTarball {
      url = https://github.com/nix-community/neovim-nightly-overlay/archive/master.tar.gz;
    }))
  ];

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "ricardo";
  home.homeDirectory = "/home/ricardo";

  home.packages = with pkgs; [
    vim
    vscode
    xclip
    ctags
    ripgrep
    bat
    fd
    git-crypt
    stow

    docker-compose
    asdf-vm
    gcc
    rustup
    stdenv.cc.cc

    nmap

    kitty
    firefox
    brave
    chromium
    discord
    spotify
    gnome.gnome-tweaks
    gnome.adwaita-icon-theme 
  ];

  programs.neovim = {
    enable = true;
    package = pkgs.neovim-nightly;
    extraPackages = with pkgs; [
        tree-sitter
        luarocks
    ];
    withNodeJs = true;
    withPython3 = true;
    withRuby = true;
  };

  programs.starship = {
    enable = true;
    settings = {
      add_newline = false;
    };
  };

  programs.gh = {
    enable = true;
    settings = {
      git_protocol = "ssh";
    };
  };

  programs.git = {
    enable = true;
    userName = "Ricardo Alves da Silva";
    userEmail = "ricardcpu@gmail.com";
    extraConfig = {
       core = { excludesfile = "/home/ricardo/.gitignore"; };
       init = { defaultBranch = "master"; };
       credential = { helper = "store"; };
       color = {
           diff = "auto";
           status = "auto";
           branch = "auto";
           interactive = "auto";
           ui = true;
           pager = true;
       };
    };
    ignores =  [
      ".vim"
      ".tasks"
      ".env"
      ".dotenv"
      "Session.vim"
    ];
  };

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "22.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}