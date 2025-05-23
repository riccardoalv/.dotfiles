{ config, pkgs, ... }:

{
  imports = [ ./configuration.nix ];

  boot = {
    kernel.sysctl = {
      "vm.vfs_cache_pressure" = 50;
      "vm.swappiness" = 10;
      "net.ipv4.tcp_congestion_control" = "bbr";
    };
    plymouth.enable = true;
    loader = {
      efi.canTouchEfiVariables = true;
      grub = {
        enable = true;
        efiSupport = true;
        device = "nodev";
        useOSProber = true;
      };
      grub2-theme = {
        enable = true;
        theme = "vimix";
      };
    };
    kernelModules = [ "tcp_bbr" "kvm-amd" "netconsole" ];
    kernelParams = [
      "quiet"
      "splash"
      "rd.systemd.show_status=false"
      "rd.udev.log_level=3"
      "udev.log_priority=3"
    ];
  };

  networking.hostName = "NixOS";
}
