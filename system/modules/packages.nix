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

  services.pipewire.wireplumber.extraConfig."10-bluez" = {
    "monitor.bluez.properties" = {
      "bluez5.enable-sbc-xq" = true;
      "bluez5.enable-msbc" = true;
      "bluez5.enable-hw-volume" = true;
      "bluez5.headset-roles" = [ "hsp_hs" "hsp_ag" "hfp_hf" "hfp_ag" ];
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
