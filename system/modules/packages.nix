{ config, pkgs, lib, ... }:

{
  environment.systemPackages = with pkgs; [
    binutils
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
  ];

  # pkgs Settings

  systemd.user.services.mpris-proxy = {
    description = "Mpris proxy";
    after = [ "network.target" "sound.target" ];
    wantedBy = [ "default.target" ];
    serviceConfig.ExecStart = "${pkgs.bluez}/bin/mpris-proxy";
  };

  hardware.pulseaudio.configFile = pkgs.writeText "default.pa" ''
    load-module module-bluetooth-policy
    load-module module-bluetooth-discover
    ## module fails to load with 
    ##   module-bluez5-device.c: Failed to get device path from module arguments
    ##   module.c: Failed to load module "module-bluez5-device" (argument: ""): initialization failed.
    # load-module module-bluez5-device
    # load-module module-bluez5-discover
  '';

  hardware.bluetooth.settings = {
    General = {
      Enable = "Source,Sink,Media,Socket";
      Experimental = true;
    };
  };

  hardware.enableAllFirmware = true;

  services.pipewire.wireplumber.extraConfig."10-bluez" = {
    "monitor.bluez.properties" = {
      "bluez5.enable-sbc-xq" = true;
      "bluez5.enable-msbc" = true;
      "bluez5.enable-hw-volume" = true;
      "bluez5.headset-roles" = [
        "hsp_hs"
        "hsp_ag"
        "hfp_hf"
        "hfp_ag"
      ];
    };
  };

  services.pipewire.extraConfig.pipewire."91-bluetooth-backend" = {
    "bluez5.hfphfp.backend" = "native";
  };

  services.pipewire.extraConfig.pipewire."91-null-sinks" = {
    "context.objects" = [
    {
      factory = "spa-node-factory";
      args = {
        "factory.name" = "support.node.driver";
        "node.name" = "Dummy-Driver";
        "priority.driver" = 8000;
      };
    }
    {
      factory = "adapter";
      args = {
        "factory.name" = "support.null-audio-sink";
        "node.name" = "Microphone-Proxy";
        "node.description" = "Microphone";
        "media.class" = "Audio/Source/Virtual";
        "audio.position" = "MONO";
      };
    }
    {
      factory = "adapter";
      args = {
        "factory.name" = "support.null-audio-sink";
        "node.name" = "Main-Output-Proxy";
        "node.description" = "Main Output";
        "media.class" = "Audio/Sink";
        "audio.position" = "FL,FR";
      };
    }
    ];
  };

  services.pipewire.extraConfig.pipewire."92-low-latency" = {
    "context.properties" = {
      "default.clock.rate" = 48000;
      "default.clock.quantum" = 32;
      "default.clock.min-quantum" = 32;
      "default.clock.max-quantum" = 32;
    };
  };

  hardware.keyboard.qmk.enable = true;

  services.flatpak.enable = true;

  virtualisation = {
    spiceUSBRedirection.enable = true;
    docker = {
      enable = true;
      enableOnBoot = false;
    };

    libvirtd.enable = true;
  };
  programs.virt-manager.enable = true;

  # Enable Audio
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  sound.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Android
  programs.adb.enable = true;

  # fish
  programs.fish.enable = true;

  environment.shells = with pkgs; [ fish ];
  users.defaultUserShell = pkgs.fish;

  # Avahi
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    publish = {
      enable = true;
      addresses = true;
      domain = true;
      hinfo = true;
      userServices = true;
      workstation = true;
    };
  };

  # Enable CUPS to print documents.
  services.printing = {
    enable = true;
    browsing = true;
    drivers = with pkgs; [ hplip ];
  };

  services.fwupd.enable = true;

  # Add git config for root
  programs.git = {
    enable = true;
    config = {
      user = {
        name = "root";
        email = "root@root.com";
      };
    };
  };
}
