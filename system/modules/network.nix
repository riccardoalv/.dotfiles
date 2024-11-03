{ config, pkgs, ... }:

{
  networking = {
    firewall = {
      enable = true;
      allowedTCPPorts = [ 22 80 443 631 1716 3000 8000 51413 57621 5353 8081 ];
      allowedUDPPorts = [ 631 1716 ];
      allowedTCPPortRanges = [{
        from = 1714;
        to = 1764;
      }];
      allowedUDPPortRanges = [{
        from = 1714;
        to = 1764;
      }];
    };
    usePredictableInterfaceNames = false;

    networkmanager.enable = true;

    extraHosts = ''
      192.168.1.1 router.local
    '';

    hostName = "NixOS-Laptop";
  };

  services.tailscale.enable = true;
}
