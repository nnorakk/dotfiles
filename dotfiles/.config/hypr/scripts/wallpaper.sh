#!/bin/sh
# Wallpaper aleatorio de ~/.config/wallpapers.
# swaybg nao aceita diretorio, entao sorteamos o arquivo aqui.
#
# Uso:
#   wallpaper.sh                # aplica UM wallpaper aleatorio e sai
#   wallpaper.sh --loop         # troca a cada 86400s (1 dia) por padrao
#   wallpaper.sh --loop 3600    # troca a cada N segundos

DIR="$HOME/.config/wallpapers"

set_random() {
    # -L: ~/.config/wallpapers e um symlink; sem isso o find nao entra nele
    img=$(find -L "$DIR" -maxdepth 1 -type f \
            \( -iname '*.jpg' -o -iname '*.jpeg' -o -iname '*.png' -o -iname '*.webp' \) \
          | shuf -n1)
    [ -n "$img" ] || return 0
    pkill -x swaybg
    swaybg -i "$img" -m fill &
}

case "${1:-}" in
    --loop)
        interval="${2:-86400}"
        while :; do
            set_random
            sleep "$interval"
        done
        ;;
    *)
        set_random
        wait
        ;;
esac
