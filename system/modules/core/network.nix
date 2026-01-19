{
  networking = {
    firewall = {
      enable = true;
      allowedTCPPorts = [
        22
        80
        443
        631
        1716
        3000
        8000
        51413
        57621
        5353
        8081
        24800
        7236
        7250
        9300
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
    networkmanager.enable = true;

    hostName = "NixOS-Laptop";
  };

  services.tailscale.enable = true;

  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
    publish = {
      enable = true;
      addresses = true;
      domain = true;
      hinfo = true;
      userServices = true;
      workstation = true;
    };
  };
}
