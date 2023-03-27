{ config, ... }: {
  home.file.".fish".source = ../../.config/fish;
  home.file.".npmrc".source = ../../npmrc;
  home.file.".config/nvim".source = ../../nvim;
  home.file.".vim".source = ../../nvim;
}

