{ pkgs, ... }:
{
  time.timeZone = "America/Porto_Velho";

  users.users.ricardo = {
    isNormalUser = true;
    home = "/home/ricardo";
    description = "Ricardo";
    extraGroups = [
      "wheel"
      "bluetooth"
      "wireshark"
      "networkmanager"
      "docker"
      "libvirtd"
      "flatpak"
      "qemu-libvirtd"
      "kvm"
      "adbusers"
      "input"
      "video"
      "render"
      "audio"
      "rtkit"
      "colord"
      "i2c"
    ];
  };

  nix = {
    optimise = {
      automatic = true;
      dates = [ "03:00" ];
    };
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };

  environment.sessionVariables.EDITOR = "nvim";
  environment.sessionVariables.VISUAL = "nvim";

  system.stateVersion = "25.05";

  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      zlib
      gcc
      openssl_3
      stdenv.cc.cc
    ];
  };
}
