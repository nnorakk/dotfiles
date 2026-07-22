#!/bin/sh
# Randomiza a cor da borda da janela em foco (col.active_border) via
# `hyprctl keyword`. O modo --loop roda dentro da sessao (lancado por
# exec-once no hyprland.conf), pois hyprctl precisa do
# HYPRLAND_INSTANCE_SIGNATURE e XDG_RUNTIME_DIR da sessao.
#
# Uso:
#   randomize-border.sh            # aplica UMA cor aleatoria e sai
#   randomize-border.sh --loop     # troca a cada 60s (default)
#   randomize-border.sh --loop 300 # troca a cada 300s

# Paleta de cores (sem o '#'); alpha 'ee' p/ casar com o estilo atual.
colors="00ded1 00ffff 406ea5 7fff00 7fffd4 8b008b d6006e daa520 ff00ff ffd700"

set_random() {
    # escolhe uma cor aleatoria da lista
    n=$(printf '%s\n' $colors | shuf -n1)
    hyprctl keyword general:col.active_border "rgba(${n}ee)" >/dev/null
}

case "${1:-}" in
    --loop)
        interval="${2:-60}"
        while :; do
            set_random
            sleep "$interval"
        done
        ;;
    *)
        set_random
        ;;
esac
