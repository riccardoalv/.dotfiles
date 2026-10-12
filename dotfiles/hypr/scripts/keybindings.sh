#!/usr/bin/env bash
# Lista os atalhos (linhas bindd) num menu pesquisável, como o omarchy-menu-keybindings

grep -h '^bind' ~/.config/hypr/bindings.conf ~/.config/hypr/bindings/*.conf 2>/dev/null |
  grep -E '^bind[a-z]*d' |
  sed -E 's/^bind[a-z]* *= *//' |
  awk -F', *' '{ mod = $1 == "" ? "" : $1 " + "; printf "%-35s %s\n", mod $2, $3 }' |
  sort |
  wofi --dmenu --prompt "Atalhos" --width 700 --height 500 >/dev/null
