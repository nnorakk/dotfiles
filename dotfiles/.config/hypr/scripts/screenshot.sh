#!/bin/sh
# Screenshot com anotacao: capturar -> ANOTAR -> escolher copiar ou salvar.
#
#   grimblast  faz a captura (area/tela) e trata o cancelamento do slurp;
#   satty      abre o editor de anotacao (setas, texto, retangulo, blur,
#              numeros) com botoes de "copiar" (wl-copy) e "salvar".
#
# Uso: screenshot.sh [area|screen|active]   (default: area)
set -e

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
