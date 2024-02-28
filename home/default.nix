{ config, pkgs, unstable, lib, ... }: {
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

    home.activation = {
      linkFishDir = ''
        ln -s -v -f \
            $HOME/.dotfiles/fish $HOME/.config/
      '';
      linkNeovimDir = ''
        ln -s -v -f \
            $HOME/.dotfiles/nvim $HOME/.config/
      '';
      linkTmuxFile = ''
        ln -s -v -f \
            $HOME/.dotfiles/dotfiles/tmux.conf $HOME/.tmux.conf
      '';
      linkGitConfig = ''
        ln -s -v -f \
            $HOME/.dotfiles/dotfiles/gitconfig $HOME/.gitconfig
      '';
      linkStarship = ''
        ln -s -v -f \
            $HOME/.dotfiles/dotfiles/starship.toml $HOME/.config/
      '';
      linkLazyGit = ''
        ln -s -v -f \
            $HOME/.dotfiles/dotfiles/config.yml $HOME/.config/lazygit/
      '';
      linkGitmux = ''
        ln -s -v -f \
            $HOME/.dotfiles/dotfiles/gitmux.conf $HOME/.gitmux.conf
      '';
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
