{ config, pkgs, ... }:
{
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    pulse.enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    jack.enable = true;

    extraConfig = {
      pipewire."92-low-latency" = {
        "context.properties" = {
          "default.clock.rate" = 48000;
          "default.clock.quantum" = 512;
          "default.clock.min-quantum" = 32;
          "default.clock.max-quantum" = 2048;
        };
      };
      pipewire-pulse."92-low-latency" = {
        context.modules = [
          {
            name = "libpipewire-module-protocol-pulse";
            args = {
              pulse.min.req = "32/48000";
              pulse.default.req = "512/48000";
              pulse.max.req = "2048/48000";
              pulse.min.quantum = "32/48000";
              pulse.max.quantum = "2048/48000";
            };
          }
        ];
        stream.properties = {
          node.latency = "512/48000";
          resample.quality = 4;
        };
      };
    };
  };
}
