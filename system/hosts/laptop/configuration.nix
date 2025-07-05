{
  config,
  pkgs,
  lib,
  ...
}:

{
  imports = [
    ./hardware.nix
    ../../modules
  ];

  boot = {
    kernelPackages = pkgs.linuxPackages_zen;
    kernel.sysctl = {
      "block/scheduler" = "bfq";
      "vm.vfs_cache_pressure" = 30;
      "vm.swappiness" = 5;
      "vm.watermark_scale_factor" = 500;
      "vm.min_free_kbytes" = 131072;
      "net.ipv4.tcp_congestion_control" = "bbr";
      "vm.overcommit_memory" = 1;
      "net.ipv4.ip_forwarding" = 1;
      "net.ipv6.conf.all.forwarding" = 1;
      "vm.dirty_writeback_centisecs" = 1500;
      "vm.dirty_expire_centisecs" = 1500;
      "vm.dirty_ratio" = 25;
      "vm.dirty_background_ratio" = 10;
    };
    plymouth = {
      enable = true;
      theme = "blockchain";
      themePackages = with pkgs; [
        (adi1090x-plymouth-themes.override {
          selected_themes = [ "blockchain" ];
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
      systemd-boot = {
        enable = lib.mkForce false;
        configurationLimit = 5;
        extraEntries = {
          "loader.conf" = ''
            default auto-efi-default
          '';
        };
      };
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
      "i2c-dev"
      "ddcci_backlight"
    ];
    kernelParams = [
      "cpufreq.default_governor=schedutil"
      "random.trust_cpu=on"
      "quiet"
      "splash"
      "rd.systemd.show_status=false"
      "rd.udev.log_level=3"
      "udev.log_priority=3"
      "amd_pstate=active"
      "loglevel=3"
      "sched_latency_ns=6000000"
      "sched_min_granularity_ns=750000"
      "threadirqs"
    ];
  };

  services.udev.extraRules = ''
    ACTION=="add|change", KERNEL=="nvme[0-9]n1", ATTR{queue/scheduler}="bfq"
    ACTION=="add|change", SUBSYSTEM=="block", ATTR{queue/rotational}=="0", ATTR{queue/scheduler}="bfq"
  '';

  services.preload.enable = true;

  security.polkit.enable = true;

  nixpkgs.config.allowUnfree = true;

  hardware = {
    enableAllFirmware = true;
    cpu.amd.updateMicrocode = true;
    graphics = {
      enable = true;
      extraPackages = with pkgs; [
        vaapiVdpau
        libvdpau-va-gl
      ];
    };
  };

  services.hdapsd.enable = true;
  services.fstrim.enable = true;

  zramSwap = {
    enable = true;
    algorithm = "lz4";
    memoryPercent = 25;
  };

  services.displayManager.autoLogin = {
    enable = true;
    user = "ricardo";
  };
}
