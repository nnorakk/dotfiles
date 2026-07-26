#!/bin/sh
# Screenshot com anotacao: capturar -> ANOTAR -> escolher copiar ou salvar.
#
#   grimblast  faz a captura (area/tela) e trata o cancelamento do slurp;
#   satty      abre o editor de anotacao (setas, texto, retangulo, blur,
#              numeros) com botoes de "copiar" (wl-copy) e "salvar".
#
# Uso: screenshot.sh [area|screen|active]   (default: area)
set -e

# GRIMBLAST_HIDE_CURSOR desliga a "danca" do grimblast que, no modo area,
# CRIA um output headless (output create headless grimblastVD) e move o foco
# pra la so pra tirar o cursor da foto. No Hyprland 0.56 isso reorganiza os
# workspaces: o monitor real passa a mostrar um workspace vazio (so o papel de
# parede) no instante do 'grim -g', e a captura sai errada. Como aqui NAO
# passamos --cursor, o cursor nunca entraria na foto -> a danca so atrapalha.
export GRIMBLAST_HIDE_CURSOR=1

mode="${1:-area}"
dir="${XDG_SCREENSHOTS_DIR:-$HOME/Pictures/Screenshots}"
mkdir -p "$dir"

tmp="$(mktemp --suffix=.png)"
trap 'rm -f "$tmp"' EXIT

# grimblast retorna != 0 se a selecao for cancelada (Esc) -> nao abre o satty
grimblast save "$mode" "$tmp" || exit 0

satty --filename "$tmp" \
    --output-filename "$dir/satty-$(date +%Y%m%d-%H%M%S).png" \
    --early-exit \
    --copy-command wl-copy
