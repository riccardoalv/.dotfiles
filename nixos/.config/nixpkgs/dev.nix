{ config, pkgs, ... }:
{
  programs.starship = {
    enable = true;
    settings = {
      add_newline = false;
    };
  };

  programs.gh = {
    enable = true;
    settings = {
      git_protocol = "ssh";
    };
  };

  programs.git = {
    enable = true;
    userName = "Ricardo Alves da Silva";
    userEmail = "ricardcpu@gmail.com";
    extraConfig = {
      core = { excludesfile = "/home/ricardo/.gitignore"; };
      init = { defaultBranch = "master"; };
      credential = { helper = "store"; };
      color = {
        diff = "auto";
        status = "auto";
        branch = "auto";
        interactive = "auto";
        ui = true;
        pager = true;
      };
    };
    ignores =  [
      ".vim"
        ".tasks"
        ".env"
        ".dotenv"
        "Session.vim"
        "shell.nix"
        "default.nix"
    ];
  };

}
