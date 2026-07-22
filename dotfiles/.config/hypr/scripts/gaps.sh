#!/bin/sh
# Gaps dinamicos em runtime.  Uso: gaps.sh +5  |  gaps.sh -5
# Guarda o valor num arquivo de estado porque "hyprctl getoption general:gaps_in"
# devolve uma estrutura de 4 lados, chata de reparsear a cada chamada.

STATE="${XDG_RUNTIME_DIR:-/tmp}/hypr-gaps"
[ -f "$STATE" ] || echo 2 > "$STATE"

cur=$(cat "$STATE")
new=$((cur + ${1:-0}))
[ "$new" -lt 0 ] && new=0
[ "$new" -gt 60 ] && new=60

echo "$new" > "$STATE"
hyprctl keyword general:gaps_in "$new"
hyprctl keyword general:gaps_out "$((new * 2))"
