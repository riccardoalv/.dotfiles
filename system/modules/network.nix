{ config, pkgs, ... }:

{
  networking = {
    firewall = {
      enable = true;
      allowedTCPPorts = [ 22 80 443 631 3000 8000 57621 ];
      allowedUDPPorts = [ 631 ];
    };
    usePredictableInterfaceNames = false;

    hostName = "NixOS"; # Define your hostname.
    networkmanager.enable = true;
  };
}
