{ config, pkgs, ... }: {
  systemd.user = {
    startServices = "legacy";
    timers.home-manager-auto-upgrade = {
      Unit.Description = "Home Manager upgrade timer";
      Install.WantedBy = [ "timers.target" ];
      Timer = {
        OnCalendar = "daily";
        Unit = "home-manager-auto-upgrade.service";
        Persistent = true;
      };
    };

    services.home-manager-auto-upgrade = {
      Unit.Description = "Home Manager upgrade";
      Service.ExecStart = toString
        (pkgs.writeShellScript "home-manager-auto-upgrade" ''
          echo "Upgrade Home Manager"
          home-manager --flake /home/ricardo/.dotfiles switch --update-input nixpkgs
        '');
    };
  };
}
