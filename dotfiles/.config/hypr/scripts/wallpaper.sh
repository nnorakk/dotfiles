#!/bin/sh
# Wallpaper aleatorio de ~/.config/wallpapers.
# swaybg nao aceita diretorio, entao sorteamos o arquivo aqui.

DIR="$HOME/.config/wallpapers"
# -L: ~/.config/wallpapers e um symlink; sem isso o find nao entra nele
img=$(find -L "$DIR" -maxdepth 1 -type f \
        \( -iname '*.jpg' -o -iname '*.jpeg' -o -iname '*.png' -o -iname '*.webp' \) \
      | shuf -n1)

[ -n "$img" ] || exit 0

pkill -x swaybg
exec swaybg -i "$img" -m fill
