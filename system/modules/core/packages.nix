{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    qmk
    binutils
    powertop
    sqlite
    bintools
    coreutils-full
    file
    dmidecode
    wget
    curl
    killall
    vim
    stow
    cifs-utils
    btrfs-progs
    gnome-network-displays
    ddcutil
    sbctl
  ];
}
