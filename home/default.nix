{ config, pkgs, unstable, lib, ... }: {
  imports = [ ./modules/dconf.nix ];
  config = {
    home.packages = with pkgs;
      [
        alacritty
        obs-studio
        # Web
        distrobox
        fragments
        docker-compose
        gparted
        piper
        wine

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
        xclip
        wl-clipboard
        appimage-run

        # Utils
        scrcpy
        nmap
        (nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" "UbuntuMono" ]; })
      ] ++ (with unstable; [
        obsidian
        # google-chrome
        vesktop
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
        mkdir -p $HOME/.config/lazygit/
        ln -s -v -f \
        $HOME/.dotfiles/dotfiles/config.yml $HOME/.config/lazygit/
      '';
      linkGitmux = ''
        ln -s -v -f \
        $HOME/.dotfiles/dotfiles/gitmux.conf $HOME/.gitmux.conf
      '';
      InstallTPM = ''
        run [ ! -d "~/.tmux/plugins/tpm" ] && mkdir -p ~/.tmux/plugins/tpm && git clone -q https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
      '';
      linkAlacritty = ''
        mkdir -p $HOME/.config/alacritty/
        ln -s -v -f \
        $HOME/.dotfiles/dotfiles/alacritty.yml $HOME/.config/alacritty/
      '';
      linkDockerStatus = ''
        mkdir -p $HOME/.tmux/plugins/tmux/custom/
        ln -s -v -f \
        $HOME/.dotfiles/dotfiles/docker_status.sh $HOME/.tmux/plugins/tmux/custom/
      '';
    };

    programs.neovim = {
      enable = true;
      defaultEditor = true;
      withNodeJs = true;
      withPython3 = true;
      withRuby = true;
      extraPackages = with pkgs; [
        lua-language-server
        rnix-lsp
        nixfmt
        stylua
        clang
        gcc
      ];
    };

    programs.firefox.enable = true;

    programs.starship.enable = true;

    home.stateVersion = "22.11";

    programs.home-manager.enable = true;
  };
}
