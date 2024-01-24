{ config, pkgs, unstable, ... }: {
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
        fzf
        lazygit
        tokei
        bat
        fd
        jq
        lua-language-server
        stylua
        scrcpy
        stow
        nixfmt
        rnix-lsp
        distrobox
        nmap
        discord
        spotify
        obsidian
        transmission-gtk
        google-chrome
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
