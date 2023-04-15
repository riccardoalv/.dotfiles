{ config, pkgs, ... }: {
  imports = [
    ./modules/dev.nix
    ./modules/alacritty.nix
    ./modules/tmux.nix
    ./modules/dconf.nix
    ./modules/dotfiles.nix
  ];
  config = {
    home.packages = with pkgs;
      [
        obs-studio
        amberol
        fragments

      ] ++ (with unstable; [
        neovim
        tree-sitter
        vscode
        xclip
        ripgrep
        bat
        fd
        tokei
        zoxide
        fzf
        lazygit
        stow
        nixfmt
        distrobox
        nmap
        discord
        spotify
        google-chrome
        obsidian
        insync
      ]);

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
