#!/bin/sh
# Alterna ocultar/reexibir janela, como o ~/bin/winhide do bspwm.
# Gaveta "hidden" vazia: oculta a janela focada.
# Senao: traz de volta a ultima ocultada para o workspace atual.

ws=$(hyprctl activeworkspace -j | jq -r '.id')

# menor focusHistoryID = foco mais recente = ultima janela ocultada
addr=$(hyprctl clients -j \
    | jq -r --arg w "special:hidden" '[.[] | select(.workspace.name == $w)] | min_by(.focusHistoryID) | .address // empty')

if [ -z "$addr" ]; then
    hyprctl dispatch movetoworkspacesilent special:hidden
else
    hyprctl dispatch movetoworkspacesilent "$ws,address:$addr"
    hyprctl dispatch focuswindow "address:$addr"
fi
