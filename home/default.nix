{ config, pkgs, unstable, ... }: {
  imports = [ ./modules/dconf.nix ];
  config = {
    home.packages = with pkgs;
      [ alacritty obs-studio ] ++ (with unstable; [

        # neovim
        neovim
        tree-sitter
        xclip
        wl-clipboard
        lua-language-server
        rnix-lsp
        nixfmt
        stylua

        # Terminal apps
        tmux
        gitmux
        fzf
        ripgrep
        zoxide
        lazygit
        tokei
        bat
        vscode
        fd
        yq
        stow
        entr

        # Web
        discord
        spotify
        obsidian
        google-chrome

        # Utils
        scrcpy
        distrobox
        nmap
        transmission-gtk
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
