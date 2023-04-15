{ config, pkgs, ... }: {
  imports = [
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
        zoxide
        fzf
        lazygit
        tokei
        bat
        fd
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

    programs.gh = {
        enable = true;
        settings = { git_protocol = "ssh"; };
    };

    home.stateVersion = "22.05";

    programs.home-manager.enable = true;
  };
}
