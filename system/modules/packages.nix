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
    sbctl
  ];

  # pkgs Settings
  hardware.bluetooth.settings = {
    General = {
      Enable = "Source,Sink,Media,Socket";
      Experimental = true;
    };
  };

  programs.obs-studio = {
    enable = true;
    enableVirtualCamera = true;
    plugins = with pkgs.obs-studio-plugins; [
      wlrobs
      obs-backgroundremoval
      obs-pipewire-audio-capture
    ];
  };

  programs.wireshark.enable = true;
  programs.wireshark.package = pkgs.wireshark-qt;

  services.udev = {
    extraRules = ''
      SUBSYSTEM=="usbmon", GROUP="wireshark", MODE="0640"
    '';
  };

  hardware.keyboard.qmk.enable = true;

  services.flatpak.enable = true;

  virtualisation = {
    spiceUSBRedirection.enable = true;
    docker = {
      enable = true;
      enableOnBoot = false;
      liveRestore = false;
    };

    libvirtd.enable = true;
  };
  programs.virt-manager.enable = true;

  # Enable Audio
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # jack.enable = true;
  };

  services.pipewire.extraConfig.pipewire."92-low-latency" = {
    "context.properties" = {
      "default.clock.rate" = 48000;
      "default.clock.quantum" = 32;
      "default.clock.min-quantum" = 32;
      "default.clock.max-quantum" = 32;
    };
  };

  services.pipewire.wireplumber.extraConfig.bluetoothEnhancements = {
    "monitor.bluez.properties" = {
      "bluez5.enable-sbc-xq" = true;
      "bluez5.enable-msbc" = true;
      "bluez5.enable-hw-volume" = true;
      "bluez5.roles" = [ "hsp_hs" "hsp_ag" "hfp_hf" "hfp_ag" ];
    };
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
    lfs.enable = true;
    enable = true;
    config = {
      user = {
        name = "root";
        email = "root@root.com";
      };
    };
  };
}
