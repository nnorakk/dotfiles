#!/bin/sh
# Feedback grafico do preselect (estilo bspwm presel_feedback).
# O dwindle guarda a direcao do preselect internamente, mas nao desenha nada.
# Este script dispara o preselect de fato E sobe um bloco translucido no
# meio-retangulo da janela ativa, onde a proxima janela vai abrir. O overlay
# some sozinho apos TTL segundos.
#
# Chamado pelos binds super+ctrl+{h,j,k,l}; "none" cancela e limpa o hint.
#   preselect-hint.sh  l | r | u | d | none
set -eu

CLASS="PreselHint"
TTL=2              # segundos que o hint fica visivel
FILL="#88c0d0"     # cor do bloco (nord frost)

dir="${1:-none}"

# nunca empilhar hints: mata o anterior (silencioso se nao houver)
pkill -f "kitty --class $CLASS" 2>/dev/null || true

# cancelar: so limpa o preselect
if [ "$dir" = "none" ]; then
    hyprctl dispatch layoutmsg "preselect none" >/dev/null 2>&1 || true
    exit 0
fi

# dispara o preselect real (o efeito que ja existia)
hyprctl dispatch layoutmsg "preselect $dir" >/dev/null

# geometria da janela ativa; se o workspace estiver vazio nao ha o que mostrar
win="$(hyprctl activewindow -j 2>/dev/null || echo '{}')"
if [ -z "$(printf '%s' "$win" | jq -r '.address // empty')" ]; then
    exit 0
fi
read -r X Y W H <<EOF
$(printf '%s' "$win" | jq -r '"\(.at[0]) \(.at[1]) \(.size[0]) \(.size[1])"')
EOF

# meio-retangulo na direcao pedida (aproxima o split em 50%)
hw=$(( W / 2 )); hh=$(( H / 2 ))
case "$dir" in
    r) X=$(( X + hw )); W=$hw ;;
    l)                  W=$hw ;;
    d) Y=$(( Y + hh )); H=$hh ;;
    u)                  H=$hh ;;
esac

# bloco translucido; a borda vem da windowrule/tema. tput civis esconde o cursor.
kitty --class "$CLASS" \
      -o background="$FILL" \
      -o background_opacity=0.15 \
      -o window_padding_width=0 \
      -o confirm_os_window_close=0 \
      sh -c "tput civis 2>/dev/null; sleep $TTL" >/dev/null 2>&1 &

# espera a janela mapear e posiciona em coords absolutas (multi-monitor ok)
addr=""
i=0
while [ "$i" -lt 60 ]; do
    addr="$(hyprctl clients -j | jq -r ".[] | select(.class==\"$CLASS\") | .address" | head -1)"
    if [ -n "$addr" ]; then break; fi
    i=$(( i + 1 ))
    sleep 0.02
done
[ -n "$addr" ] || exit 0

hyprctl --batch "dispatch resizewindowpixel exact $W $H,address:$addr ; dispatch movewindowpixel exact $X $Y,address:$addr" >/dev/null
