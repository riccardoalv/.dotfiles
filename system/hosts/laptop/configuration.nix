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
      "vm.vfs_cache_pressure" = 50;
      "vm.swappiness" = 20;
      "vm.watermark_scale_factor" = 500;
      "vm.min_free_kbytes" = 131072;
      "net.ipv4.tcp_congestion_control" = "bbr";
      "vm.overcommit_memory" = 1;
      "net.ipv4.ip_forward" = 1;
      "net.ipv6.conf.all.forwarding" = 1;
      "vm.dirty_expire_centisecs" = 5000;
      "vm.dirty_ratio" = 25;
      "vm.dirty_background_ratio" = 10;
      "vm.dirty_background_bytes" = 64 * 1024 * 1024;
      "vm.dirty_bytes" = 256 * 1024 * 1024;
      "vm.dirty_writeback_centisecs" = 5000;
      "sched_latency_ns" = 6000000;
      "sched_min_granularity_ns" = 750000;
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
      pkiBundle = "/var/lib/sbctl";
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
      "kvm-intel"
      "netconsole"
      "i2c-dev"
      "ddcci_backlight"
      "i915"
      "intel_uncore_frequency"
      "x86_pkg_temp_thermal"
      "nvme"
      "hid_lenovo"
    ];
    kernelParams = [
      "intel_pstate=passive"
      "i915.enable_psr=1"
      "i915.force_probe=a7a0"
      "cpufreq.default_governor=schedutil"
      "random.trust_cpu=on"
      "quiet"
      "splash"
      "rd.systemd.show_status=false"
      "rd.udev.log_level=3"
      "udev.log_priority=3"
      "loglevel=3"
      "threadirqs"
    ];
  };

  services.udev.extraRules = ''
    ACTION=="add|change", KERNEL=="nvme[0-9]n1", ATTR{queue/scheduler}="none"
  '';

  services.preload.enable = true;

  security.polkit.enable = true;

  nixpkgs.config.allowUnfree = true;

  services.power-profiles-daemon.enable = true;

  hardware = {
    enableAllFirmware = true;
    cpu.intel.updateMicrocode = true;
    sensor.iio.enable = true;
    graphics = {
      enable = true;
      extraPackages = with pkgs; [
        vaapiVdpau
        libvdpau-va-gl
        vpl-gpu-rt
      ];
    };
  };

  systemd.services.fprintd = {
    wantedBy = [ "multi-user.target" ];
    serviceConfig.Type = "simple";
  };

  services.fprintd = {
    enable = true;
    tod = {
      enable = true;
      driver = pkgs.libfprint-2-tod1-goodix-550a;
    };
  };

  services.hdapsd.enable = true;
  services.fstrim.enable = true;

  swapDevices = [
    {
      device = "/var/lib/swapfile";
      size = 32 * 1024;
    }
  ];

  services.displayManager.autoLogin = {
    enable = true;
    user = "ricardo";
  };
}
