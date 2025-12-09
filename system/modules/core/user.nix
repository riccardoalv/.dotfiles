{ pkgs, ... }: {
  time.timeZone = "America/Porto_Velho";

  users.users.ricardo = {
    isNormalUser = true;
    home = "/home/ricardo";
    description = "Ricardo";
    extraGroups = [
      "wheel"
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
      "audio"
      "rtkit"
      "colord"
      "i2c"
    ];
  };

  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    auto-optimise-store = true;
  };

  environment.sessionVariables.EDITOR = "nvim";
  environment.sessionVariables.VISUAL = "nvim";

  system.stateVersion = "25.05";

  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [ zlib gcc openssl_3 stdenv.cc.cc ];
  };

}
