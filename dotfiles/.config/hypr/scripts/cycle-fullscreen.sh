#!/bin/sh
# Cicla o foco entre as janelas do workspace preservando o estado de
# fullscreen/monocle da janela atual (comportamento estilo bspwm: com uma
# janela em fullscreen, o "circle" leva o fullscreen junto para a proxima).
#
# Uso: cycle-fullscreen.sh [prev]
#   sem argumento -> proxima janela (cyclenext)
#   "prev"        -> janela anterior (cyclenext prev)

dir="$1"

# Estado atual de fullscreen (enum eFullscreenMode):
#   0 = nenhum, 1 = maximizado (monocle), 2 = fullscreen real
fs=$(hyprctl activewindow -j | jq -r '.fullscreen')

if [ "$dir" = "prev" ]; then
    hyprctl dispatch cyclenext prev
else
    hyprctl dispatch cyclenext
fi

# Reaplica o mesmo estado na janela recem-focada. fullscreenstate recebe o
# mesmo valor lido acima (internal), com -1 no client para nao mexer nele.
if [ "$fs" != "0" ] && [ "$fs" != "null" ]; then
    hyprctl dispatch fullscreenstate "$fs" -1
fi
