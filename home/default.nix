{ config, pkgs, ... }: {
  imports = [ ./modules/dconf.nix ];
  config = {
    home.packages = with pkgs;
      [ alacritty obs-studio tmux ] ++ (with unstable; [
        neovim
        tree-sitter
        vscode
        xclip
        ripgrep
        zoxide
        cz-cli
        fzf
        lazygit
        tokei
        bat
        fd
        stow
        nixfmt
        rnix-lsp
        distrobox
        nmap
        discord
        spotify
        google-chrome
        obsidian
        docker-compose
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

    programs.starship.enable = true;

    home.stateVersion = "22.05";

    programs.home-manager.enable = true;
  };
}
