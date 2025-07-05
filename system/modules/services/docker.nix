{
  virtualisation.docker = {
    enable = true;
    enableOnBoot = false;
    liveRestore = false;
  };

  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;
}
