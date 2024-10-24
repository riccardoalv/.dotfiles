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
      "net.ipv4.ip_forwarding" = 1;
      "net.ipv6.conf.all.forwarding" = 1;
    };
    plymouth = {
      enable = true;
      theme = "circle_hud";
      themePackages = with pkgs; [
        (adi1090x-plymouth-themes.override {
         selected_themes = [ "circle_hud" ];
         })
      ];
    };
    consoleLogLevel = 0;
    initrd = {
      verbose = false;
      systemd.enable = true;
    };

    lanzaboote = {
      enable = true;
      pkiBundle = "/etc/secureboot";
    };

    loader = {
      systemd-boot.enable = lib.mkForce false;
      efi.canTouchEfiVariables = true;

      grub = {
        enable = false;
        efiSupport = false;
        device = "nodev";
        useOSProber = true;
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
      "boot.shell_on_fail"
      "loglevel=3"
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
    size = 24 * 1024;
  }];
  services.displayManager.autoLogin = {
    enable = true;
    user = "ricardo";
  };
  services.power-profiles-daemon.enable = false;
  services.thermald.enable = true;

  programs.auto-cpufreq.enable = true;
  programs.auto-cpufreq.settings = {
    charger = {
      governor = "performance";
      turbo = "auto";
    };

    battery = {
      governor = "powersave";
      turbo = "never";
    };
  };

  networking.hostName = "NixOS-Laptop";
}
