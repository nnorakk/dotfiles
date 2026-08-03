#!/bin/sh
# Abre uma janela eww no monitor certo (casando pelo MODELO do monitor) e
# GARANTE que a surface realmente subiu no compositor, reabrindo em loop se nao.
#
# Dois problemas que este script resolve:
#
# 1) Indice de monitor instavel: o indice GDK/eww NAO e estavel entre logins
#    (apos o GDM a ordem inverte e o indice fixo cai no LG principal). O eww
#    0.5.0 so aceita indice inteiro, nao nome/modelo — entao descobrimos em
#    runtime qual indice GDK corresponde ao monitor alvo (pelo modelo) e
#    abrimos la com --screen.
#
# 2) "Aberta mas invisivel": as vezes o `eww open` registra a janela como
#    active no daemon, mas a surface layer-shell NUNCA e mapeada no compositor
#    (bug de corrida no login, antes dos outputs estarem prontos). O eww segue
#    reportando a janela como aberta, mas ela nao aparece. Aqui conferimos no
#    `hyprctl layers` se a surface (gtk-layer-shell, pid do daemon eww) de fato
#    apareceu no monitor alvo e, se nao, fechamos e reabrimos ate conseguir.
#
# Uso:  eww-screen.sh <janela> <modelo>
#   ex: eww-screen.sh saldo   "24P1W1"
#       eww-screen.sh relogio "24P1W1"
#
# Sem `set -e`: o loop de retry precisa tolerar comandos que falham (close de
# janela inexistente, testes que dao falso, pgrep sem match, etc.).
set -u

win="${1:?uso: eww-screen.sh <janela> <modelo-do-monitor>}"
match="${2:-}"

RUNDIR="${XDG_RUNTIME_DIR:-/tmp}"
LOG="$RUNDIR/eww-screen.log"
LOCK="$RUNDIR/eww-screen.lock"
ATTEMPTS=5          # quantas vezes tentar (fechar+)abrir a janela
SETTLE_TRIES=16     # esperas pela surface por tentativa (~SETTLE_TRIES*SLEEP s)
SETTLE_SLEEP=0.25

log() { printf '%s [%s] %s\n' "$(date +%H:%M:%S)" "$win" "$*" >>"$LOG"; }

# Evita o log crescer sem fim a cada login (~4 linhas por janela por sessao).
[ -f "$LOG" ] && [ "$(wc -c <"$LOG" 2>/dev/null || echo 0)" -gt 51200 ] && : >"$LOG"

# Serializa as duas chamadas (saldo/relogio): a verificacao usa contagem-delta
# de surfaces no monitor, entao so uma pode mexer nisso por vez.
if command -v flock >/dev/null 2>&1; then
    exec 9>"$LOCK"
    flock 9
fi

# --- Garante o daemon do eww vivo e respondendo -----------------------
# `9>&-` fecha o fd do lock NO FILHO: senao o daemon do eww herda o fd 9 (com
# o flock junto) e, como ele persiste, o lock nunca e liberado — a 2a janela
# ficaria travada no flock pra sempre.
eww daemon 9>&- >/dev/null 2>&1 || true
i=0
while [ "$i" -lt 20 ]; do
    eww ping >/dev/null 2>&1 && break
    sleep 0.25; i=$((i + 1))
done

# --- 1) Indice GDK do monitor alvo (para o --screen do eww) -----------
find_gdk_screen() {
    python3 - "$match" <<'PY'
import sys
try:
    import gi
    gi.require_version("Gdk", "3.0")
    from gi.repository import Gdk
    want = sys.argv[1].lower()
    d = Gdk.Display.get_default()
    for i in range(d.get_n_monitors()):
        if want and want in (d.get_monitor(i).get_model() or "").lower():
            print(i); break
    else:
        print("none")
except Exception:
    print("none")
PY
}

screen="none"; i=0
while [ "$i" -lt 10 ]; do
    screen="$(find_gdk_screen)"
    [ "$screen" != "none" ] && break
    sleep 0.5; i=$((i + 1))
done
[ "$screen" != "none" ] || screen=0   # fallback: 1o monitor
log "indice GDK=$screen (modelo '$match')"

# --- 2) Nome do conector Hypr do monitor alvo (para conferir a surface) --
# NB: usar `python3 -c` (nao heredoc) porque o stdin do python e o pipe do
# hyprctl; um heredoc <<PY roubaria esse stdin e json.load leria o script.
mon="$(
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
        print(m.get("name", "")); break
else:
    print("")
' "$match"
)"
log "monitor Hypr='$mon'"

# Pid do daemon eww, para filtrar so as surfaces dele (nao de outras apps
# gtk-layer-shell). Se vazio, o parser aceita qualquer gtk-layer-shell.
eww_pid="$(pgrep -x eww 2>/dev/null | head -n1)"

# Conta surfaces gtk-layer-shell do eww no monitor alvo. Ignora surfaces
# orfas (pid<=0): sao restos de um daemon anterior, nao janelas nossas vivas.
count_surfaces() {
    [ -n "$mon" ] || { echo 0; return; }
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
' "$mon" "${eww_pid:-0}"
}

# `9>&-` por seguranca: se por acaso um `eww open` acabar subindo um daemon
# (nao deveria, ja garantimos acima), ele nao pode herdar o lock.
open_win() {
    eww open "$win" --screen "$screen" 9>&- >/dev/null 2>&1 \
        || eww open "$win" 9>&- >/dev/null 2>&1 || true
}

wait_ge() {  # espera a contagem chegar a >= $1
    _t="$1"; _k=0
    while [ "$_k" -lt "$SETTLE_TRIES" ]; do
        [ "$(count_surfaces)" -ge "$_t" ] && return 0
        sleep "$SETTLE_SLEEP"; _k=$((_k + 1))
    done
    return 1
}
wait_le() {  # espera a contagem cair para <= $1
    _t="$1"; _k=0
    while [ "$_k" -lt "$SETTLE_TRIES" ]; do
        [ "$(count_surfaces)" -le "$_t" ] && return 0
        sleep "$SETTLE_SLEEP"; _k=$((_k + 1))
    done
    return 1
}

# Sem monitor Hypr resolvido nao ha como verificar: abre uma vez e sai.
if [ -z "$mon" ]; then
    log "monitor Hypr nao resolvido; abrindo sem verificacao"
    open_win
    exit 0
fi

# --- 3) Abre com verificacao + retry ----------------------------------
# Parte de um baseline conhecido: fecha esta janela e deixa assentar.
eww close "$win" >/dev/null 2>&1 || true
sleep 0.4
baseline="$(count_surfaces)"
log "baseline de surfaces no monitor=$baseline"

ok=0; a=0
while [ "$a" -lt "$ATTEMPTS" ]; do
    a=$((a + 1))
    open_win
    if wait_ge $((baseline + 1)); then
        log "surface mapeada na tentativa $a"
        ok=1; break
    fi
    log "tentativa $a: surface nao subiu; fechando p/ reabrir"
    eww close "$win" >/dev/null 2>&1 || true
    wait_le "$baseline" || true
done

[ "$ok" = 1 ] || log "FALHA: '$win' nao mapeou apos $ATTEMPTS tentativas"
exit 0
