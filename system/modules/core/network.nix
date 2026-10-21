{
  networking = {
    firewall = {
      enable = true;
      allowedTCPPorts = [
        631
        1716
        51413
        57621
        24800
        7236
        7250
        24454
      ];
      allowedUDPPorts = [
        631
        1716
        24800
        7236
        5353
      ];
      allowedTCPPortRanges = [
        {
          from = 1714;
          to = 1764;
        }
      ];
      allowedUDPPortRanges = [
        {
          from = 1714;
          to = 1764;
        }
      ];
    };

    usePredictableInterfaceNames = false;

    networkmanager = {
      enable = true;
      unmanaged = [
        "interface-name:p2p-wlan0-*"
        "interface-name:p2p-dev-*"
      ];
    };

    hostName = "NixOS-Laptop";
  };

  services.tailscale.enable = true;

  services.dnsmasq.enable = true;

  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
    settings.publish = {
      disable-publishing = false;
      disable-user-service-publishing = false;
      publish-addresses = true;
      publish-domain = true;
      publish-hinfo = true;
      publish-workstation = true;
    };
  };

  services.openiscsi = {
    enable = true;
    name = "iqn.1993-08.org.debian:01:laptop-ricardo";
  };
}
