{ config, pkgs, unstable, ... }: {
  imports = [ ./modules/dconf.nix ];
  config = {
    home.packages = with pkgs;
      [ alacritty obs-studio ] ++ (with unstable; [
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
        jq
        stow
        entr
        gh

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
        gparted
      ]);

    qt = {
      enable = true;
      style = {
        name = "adwaita-dark";
        package = pkgs.adwaita-qt;
      };
    };

    programs.neovim = {
      enable = true;
      defaultEditor = true;
      withNodeJs = true;
      withPython3 = true;
      withRuby = true;
      plugins = [ pkgs.vimPlugins.nvim-treesitter.withAllGrammars ];
      extraPackages = with pkgs; [
        xclip
        wl-clipboard
        lua-language-server
        rnix-lsp
        nixfmt
        stylua
      ];
    };

    programs.firefox.enable = true;

    programs.starship.enable = true;

    home.stateVersion = "22.05";

    programs.home-manager.enable = true;
  };
}
