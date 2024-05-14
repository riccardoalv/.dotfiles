{ config, pkgs, lib, ... }:

{
  nixpkgs.config.allowUnfree = true;
  imports = [ ./configuration.nix ];

  boot = {
    kernel.sysctl = {
      "vm.vfs_cache_pressure" = 50;
      "vm.swappiness" = 5;
      "vm.watermark_scale_factor" = 500;
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
      grub2-theme = {
        enable = true;
        theme = "vimix";
      };
    };
    kernelModules = [
      "tcp_bbr"
      "kvm-amd"
      "netconsole"
      "amd-pstate"
      "amdgpu"
      "v4l2loopback"
      "v4l2loopback-dc"
      "snd-aloop"
    ];
    kernelParams = [
      "quiet"
      "splash"
      "rd.systemd.show_status=false"
      "rd.udev.log_level=3"
      "udev.log_priority=3"
      "amd_pstate=active"
    ];
    extraModulePackages = with config.boot.kernelPackages; [ v4l2loopback.out ];
    extraModprobeConfig = ''
      options v4l2loopback exclusive_caps=1 card_label="Virtual Camera"
    '';
  };

  security.polkit.enable = true;

  hardware = {
    enableAllFirmware = true;
    cpu.amd.updateMicrocode = true;
    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
      setLdLibraryPath = true;
      extraPackages = with pkgs; [
        vaapiVdpau
        libvdpau-va-gl
      ];
    };
  };

  services.hdapsd.enable = true;
  services.fstrim.enable = true;

  swapDevices = [{
    device = "/swapfile";
    size = 6 * 1024;
  }];
  services.displayManager.autoLogin = {
    enable = true;
    user = "ricardo";
  };
  services.power-profiles-daemon.enable = false;
  services.thermald.enable = true;
  services.auto-cpufreq.enable = true;
  services.auto-cpufreq.settings = {
    battery = {
      governor = "powersave";
      turbo = "never";
    };
    charger = {
      governor = "performance";
      turbo = "auto";
    };
  };
}
