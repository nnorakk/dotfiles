#!/bin/sh
# =====================================================================
# Ponte polybar -> waybar
#
# Executa um script de polybar SEM ALTERA-LO e converte a saida:
#   %{F#rrggbb} ... %{F-}   ->   <span color="#rrggbb"> ... </span>
#
# Tambem fecha spans abertos sem %{F-} (o battery.sh faz isso), senao
# o Pango descarta a linha inteira e o modulo aparece vazio.
#
# head -n1 replica o comportamento do polybar, que usa so a 1a linha
# (relevante p/ openvpn-isrunning.sh, que imprime duas — ver README).
#
# Uso:  polybar-shim.sh <comando> [args...]
# =====================================================================

"$@" 2>/dev/null | head -n1 | awk '
{
    line = $0
    # converte aberturas
    while (match(line, /%\{F#[0-9a-fA-F]{6,8}\}/)) {
        cor = substr(line, RSTART + 4, RLENGTH - 5)
        line = substr(line, 1, RSTART - 1) "<span color=\"#" cor "\">" substr(line, RSTART + RLENGTH)
        abertos++
    }
    # converte fechamentos
    while (match(line, /%\{F-\}/)) {
        line = substr(line, 1, RSTART - 1) "</span>" substr(line, RSTART + RLENGTH)
        abertos--
    }
    # fecha o que ficou aberto
    while (abertos-- > 0) line = line "</span>"
    print line
}'
