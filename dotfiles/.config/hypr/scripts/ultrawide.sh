#!/bin/sh
# Reduz a area util em telas ultrawide, inflando gaps_out lateralmente
# (760px de cada lado), o que produz uma coluna central estreita.
# Segunda invocacao restaura os gaps normais.

STATE="${XDG_RUNTIME_DIR:-/tmp}/hypr-ultrawide"
PAD=760

if [ -f "$STATE" ]; then
    rm -f "$STATE"
    hyprctl keyword general:gaps_out 4
else
    touch "$STATE"
    # gaps_out aceita: topo direita baixo esquerda
    hyprctl keyword general:gaps_out "4 $PAD 4 $PAD"
fi
