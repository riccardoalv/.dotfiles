{ ... }:
{
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Opens ports for Steam Remote Play
    dedicatedServer.openFirewall = true; # Opens ports for servers
  };

}
