#!/bin/sh
# Abre uma janela eww no monitor certo (casando pelo MODELO do monitor),
# resiliente a reordenacao de indices GDK entre sessoes.
#
# Porque nao basta :monitor no eww.yuck: o indice de monitor do GDK/eww NAO e
# estavel entre logins (apos o GDM a ordem inverte e o indice fixo cai no LG
# principal). O eww 0.5.0 so aceita indice inteiro, nao nome/modelo — entao
# aqui descobrimos, em runtime, qual indice GDK corresponde ao monitor alvo
# (casando pelo modelo passado) e abrimos la com --screen.
#
# Uso:  eww-screen.sh <janela> <modelo>
#   ex: eww-screen.sh saldo   "24P1W1"
#       eww-screen.sh relogio "24P1W1"
set -eu

win="${1:?uso: eww-screen.sh <janela> <modelo-do-monitor>}"
match="${2:-}"

# Garante o daemon do eww antes de abrir.
eww daemon >/dev/null 2>&1 || true

# Descobre o indice GDK do monitor alvo. Tenta por ~5s pois, logo apos o login,
# o 2o monitor pode ainda nao estar registrado quando este exec-once dispara.
find_screen() {
    python3 - "$match" <<'PY'
import sys
try:
    import gi
    gi.require_version("Gdk", "3.0")
    from gi.repository import Gdk
    want = sys.argv[1].lower()
    d = Gdk.Display.get_default()
    for i in range(d.get_n_monitors()):
        model = (d.get_monitor(i).get_model() or "").lower()
        if want and want in model:
            print(i)
            break
    else:
        print("none")
except Exception:
    print("none")
PY
}

screen="none"
i=0
while [ "$i" -lt 10 ]; do
    screen="$(find_screen)"
    [ "$screen" != "none" ] && break
    sleep 0.5
    i=$((i + 1))
done
[ "$screen" != "none" ] || screen=0   # fallback: 1o monitor

eww close "$win" >/dev/null 2>&1 || true
exec eww open "$win" --screen "$screen"
