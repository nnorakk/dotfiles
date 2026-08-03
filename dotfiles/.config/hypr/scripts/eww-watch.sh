#!/bin/sh
# Vigia (self-heal) as janelas eww no monitor auxiliar e as reabre quando somem.
#
# Por que e preciso: um ciclo de dpms off/on (o hypridle faz isso aos 5,5min de
# idle) ou um hotplug DESABILITA o output do AOC (DP-3) e o Hyprland destroi as
# surfaces layer-shell nele. O eww 0.5.0 NAO as recria — a janela fica "active"
# sem surface, e os widgets somem. E o Hyprland NAO emite evento no socket2 para
# dpms (so para hotplug real), entao nao da para so ouvir eventos: verificamos
# por polling e reabrimos via eww-screen.sh (que ja casa o monitor e faz retry).
#
# Sobe uma vez (exec-once) no host-darkstar. Tambem faz a abertura inicial: na
# 1a iteracao nao ha surface, entao ele abre.
set -u

MODEL="24P1W1"          # monitor auxiliar (AOC) — casado por modelo
WINS="saldo relogio"    # janelas eww gerenciadas
INTERVAL=7              # segundos entre verificacoes
SCR="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd -P)"
LOG="${XDG_RUNTIME_DIR:-/tmp}/eww-screen.log"

log() { printf '%s [watch] %s\n' "$(date +%H:%M:%S)" "$*" >>"$LOG"; }

expected="$(set -- $WINS; echo $#)"   # quantas janelas esperamos ver

# Monitor alvo: imprime "NAME DPMS" (ex.: "DP-3 True") ou nada se ausente.
mon_state() {
    hyprctl monitors -j 2>/dev/null | python3 -c '
import sys, json
want = sys.argv[1].lower()
try:
    mons = json.load(sys.stdin)
except Exception:
    mons = []
for m in mons:
    hay = " ".join(str(m.get(k, "")) for k in ("model", "description", "make")).lower()
    if want and want in hay:
        print(m.get("name", ""), bool(m.get("dpmsStatus"))); break
' "$MODEL"
}

# Nº de surfaces gtk-layer-shell vivas do eww no monitor $1.
surf_count() {
    _pid="$(pgrep -x eww 2>/dev/null | head -n1)"
    hyprctl layers -j 2>/dev/null | python3 -c '
import sys, json
mon = sys.argv[1]; pid = int(sys.argv[2] or 0)
try:
    d = json.load(sys.stdin)
except Exception:
    d = {}
n = 0
for arr in d.get(mon, {}).get("levels", {}).values():
    for s in arr:
        if s.get("namespace") == "gtk-layer-shell" and s.get("pid", -1) > 0 \
                and (pid == 0 or s.get("pid") == pid):
            n += 1
print(n)
' "$1" "${_pid:-0}"
}

reopen_all() {
    for w in $WINS; do "$SCR/eww-screen.sh" "$w" "$MODEL"; done
}

log "watcher iniciado (model=$MODEL, wins='$WINS', intervalo=${INTERVAL}s)"
while :; do
    st="$(mon_state)"
    name="${st%% *}"
    dpms="${st##* }"
    # So agimos com o AOC presente e LIGADO (dpms on): reabrir com o output
    # desabilitado so falharia e geraria retries a toa.
    if [ -n "$name" ] && [ "$dpms" = "True" ]; then
        have="$(surf_count "$name")"
        if [ "${have:-0}" -lt "$expected" ]; then
            log "monitor $name up, surfaces=${have}/${expected} -> reabrindo"
            reopen_all
        fi
    fi
    sleep "$INTERVAL"
done
