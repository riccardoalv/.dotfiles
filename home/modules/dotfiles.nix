{ config, ... }: {
  home.file.".config/nvim".source = ../../nvim;
  home.file.".fish".source = ../../.config/fish;
  home.file.".config/alacritty/alacritty.yml".source = ../../dotfiles/alacritty.yml;
  home.file.".tmux.conf".source = ../../dotfiles/tmux.conf;
  home.file.".gitconfig".source = ../../dotfiles/gitconfig;
  home.file.".npmrc".source = ../../dotfiles/npmrc;
  home.file.".config/lazygit/config.yml".source = ../../dotfiles/config.yml;
}
