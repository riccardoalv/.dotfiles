{ config, pkgs, ... }: {
  programs.starship = {
    enable = true;
    settings = {
      add_newline = false;
      battery = { disabled = true; };
    };
  };

  programs.gh = {
    enable = true;
    settings = { git_protocol = "ssh"; };
  };

  programs.git = {
    enable = true;
    userName = "Ricardo Alves da Silva";
    userEmail = "ricardcpu@gmail.com";
    extraConfig = {
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
      difftool = { prompt = true;};
      diff = { tool = nvimdiff;};
      difftool_"nvimdiff" = { cmd = "nvim -d \"$LOCAL\" \"$REMOTE\"";};
    };
    ignores = [ "tags" "Session.vim" ];
  };
}
