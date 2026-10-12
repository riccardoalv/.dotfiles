{ pkgs, ... }:
{
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  programs.hyprlock.enable = true;

  # Iniciado via exec-once no hyprland.conf para nao rodar dentro do GNOME
  systemd.user.services.hyprpolkitagent = {
    description = "Hyprland Polkit authentication agent";
    serviceConfig = {
      ExecStart = "${pkgs.hyprpolkitagent}/libexec/hyprpolkitagent";
      Restart = "on-failure";
    };
  };

  # Regras udev para o swayosd controlar brilho sem root
  services.udev.packages = [ pkgs.swayosd ];

  # Icones da waybar/wofi no estilo Omarchy
  fonts.packages = [ pkgs.nerd-fonts.jetbrains-mono ];

  environment.systemPackages = with pkgs; [
    waybar
    wofi
    mako
    hypridle
    swaybg
    swayosd
    hyprpicker
    hyprshot
    cliphist
    btop
    grim
    slurp
    brightnessctl
    playerctl
    pamixer
    networkmanagerapplet
  ];
}
