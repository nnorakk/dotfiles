#!/bin/sh
# Oculta TODAS as janelas do workspace atual — equivale a:
#   bspc query -N -n .local.window | xargs -I ID bspc node ID -g hidden
# Segunda invocacao traz tudo de volta (o bspwm nao fazia isso; aqui e de graca).

ws=$(hyprctl activeworkspace -j | jq -r '.id')

# Se a gaveta "hidden" ja tem janelas, restaura em vez de ocultar
n_hidden=$(hyprctl clients -j | jq --arg w "special:hidden" '[.[] | select(.workspace.name == $w)] | length')

if [ "$n_hidden" -gt 0 ]; then
    hyprctl clients -j \
        | jq -r --arg w "special:hidden" '.[] | select(.workspace.name == $w) | .address' \
        | while read -r addr; do
              hyprctl dispatch movetoworkspacesilent "$ws,address:$addr"
          done
else
    hyprctl clients -j \
        | jq -r --argjson w "$ws" '.[] | select(.workspace.id == $w) | .address' \
        | while read -r addr; do
              hyprctl dispatch movetoworkspacesilent "special:hidden,address:$addr"
          done
fi
