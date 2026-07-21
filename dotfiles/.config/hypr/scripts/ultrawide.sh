#!/bin/sh
# Reduz a area util em telas ultrawide — equivale ao seu super+n:
#   bspc config left_monocle_padding 760 / right_monocle_padding 760
# No Hyprland nao ha "monocle padding"; o equivalente e inflar gaps_out
# lateralmente, o que produz o mesmo efeito de coluna central estreita.

STATE="${XDG_RUNTIME_DIR:-/tmp}/hypr-jp-ultrawide"
PAD=760

if [ -f "$STATE" ]; then
    rm -f "$STATE"
    hyprctl keyword general:gaps_out 4
else
    touch "$STATE"
    # gaps_out aceita: topo direita baixo esquerda
    hyprctl keyword general:gaps_out "4 $PAD 4 $PAD"
fi
