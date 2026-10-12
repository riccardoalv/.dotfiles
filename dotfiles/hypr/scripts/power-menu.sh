#!/usr/bin/env bash
# Menu de sistema estilo Omarchy (wofi dmenu)

choice=$(printf '  Lock\n󰤄  Suspend\n  Relaunch Hyprland\n󰜉  Restart\n󰐥  Shutdown\n󰗽  Logout' |
  wofi --dmenu --prompt "System" --width 300 --height 260)

case "$choice" in
*Lock) loginctl lock-session ;;
*Suspend) systemctl suspend ;;
*Relaunch*) hyprctl dispatch forcerendererreload && hyprctl reload ;;
*Restart) systemctl reboot ;;
*Shutdown) systemctl poweroff ;;
*Logout) hyprctl dispatch exit ;;
esac
