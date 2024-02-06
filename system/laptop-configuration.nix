{ config, pkgs, lib, ... }:

{
  nixpkgs.config.allowUnfree = true;
  imports = [ ./configuration.nix ];

  boot = {
    kernel.sysctl = {
      "vm.vfs_cache_pressure" = 50;
      "vm.swappiness" = 10;
      "net.ipv4.tcp_congestion_control" = "bbr";
      "vm.overcommit_memory" = 1;
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
    };
    kernelModules = [ "tcp_bbr" "kvm-amd" "netconsole" "amd-pstate" "amdgpu" ];
    kernelParams = [
      "quiet"
      "splash"
      "rd.systemd.show_status=false"
      "rd.udev.log_level=3"
      "udev.log_priority=3"
      "amd_pstate=active"
    ];
  };

  hardware = {
    cpu.amd.updateMicrocode = true;
    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
      setLdLibraryPath = true;
    };
  };

  services.hdapsd.enable = true;
  services.fstrim.enable = true;

  system.autoUpgrade = {
    enable = true;
    flake = "/home/ricardo/.dotfiles#laptop";
    flags = [
      "--update-input"
      "nixpkgs"
      "--update-input"
      "nixpkgs-unstable"
      "--impure"
    ];
    dates = "daily";
  };
  swapDevices = [{
    device = "/var/lib/swapfile";
    size = 2 * 1024;
  }];
  services.power-profiles-daemon.enable = false;
  services.auto-cpufreq.enable = true;
}
