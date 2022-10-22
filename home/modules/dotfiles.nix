{ config, ... }: {
  home.file.".zshrc".source = ../../zshrc;
  home.file.".npmrc".source = ../../npmrc;
  home.file.".config/nvim".source = ../../nvim;
  home.file.".vim".source = ../../nvim;
}

