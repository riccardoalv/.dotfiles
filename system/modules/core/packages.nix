{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    evtest
    libnotify
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
    ddcutil
    sbctl
  ];
}
