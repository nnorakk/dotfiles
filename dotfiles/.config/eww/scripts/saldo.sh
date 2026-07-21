#!/bin/sh
# Coleta o saldo de ponto e converte o markup conky numa arvore de widgets eww.
# Usado pelo defpoll "saldo_tree" no eww.yuck (porta do conky.conf.5, darkstar).
# Se o coletor falhar (sem VPN/Oracle), devolve um widget de aviso em vez de vazio.
set -eu

collector="$HOME/Python/Diversos/analisa_saldo_semanal.sh"
out="$("$collector" 2>/dev/null || true)"

if [ -z "$out" ]; then
    printf '%s\n' '(label :class "saldo" :text "saldo indisponivel")'
    exit 0
fi

printf '%s\n' "$out" | python3 "$HOME/.config/eww/scripts/conky2eww.py"
