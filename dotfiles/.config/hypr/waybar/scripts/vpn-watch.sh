#!/bin/sh
# =====================================================================
# Watcher da VPN SonicWall -> atualiza o icone da waybar na hora.
#
# 'ip monitor link' emite um evento sempre que uma interface de rede
# aparece, some ou muda de estado. Quando o evento envolve o tunel
# 'snwl_ssltunnel', mandamos SIGRTMIN+8 para a waybar, que reexecuta o
# modulo custom/openvpn (definido com "signal": 8) e troca a cor na hora.
#
# Assim o icone reflete conexao/desconexao instantaneamente, sem depender
# do "interval", e independente de COMO a VPN mudou (clique no modulo,
# netExtender via CLI, reconexao automatica do loop, timeout).
#
# Rodar uma vez por sessao (exec-once no Hyprland).
# =====================================================================

SIG=8
IFACE="snwl_ssltunnel"

# ---------------------------------------------------------------------
# CUIDADO: so sinalizar depois que a waybar estiver PRONTA.
#
# A waybar so instala o handler de SIGRTMIN+8 depois de montar os
# modulos. Se o sinal chega antes disso, vale a acao default de um sinal
# real-time, que e MATAR o processo -- e a barra some sem escrever uma
# linha sequer de log. Como este watcher e um exec-once disparado no
# mesmo instante que o da waybar, no boot frio ele ganhava a corrida e
# derrubava a barra.
# ---------------------------------------------------------------------
sinaliza() {
    pgrep -x waybar >/dev/null 2>&1 || return 0
    pkill --signal "RTMIN+${SIG}" waybar 2>/dev/null
}

# espera a waybar aparecer (ate ~30s) e da uma margem para ela registrar
# os handlers de sinal
i=0
while [ "$i" -lt 60 ]; do
    pgrep -x waybar >/dev/null 2>&1 && break
    i=$((i + 1))
    sleep 0.5
done
sleep 2

# sinaliza uma vez no inicio para garantir o estado correto ao logar
sinaliza

# stdbuf -oL forca line-buffering: sem isso o 'ip monitor' bufferiza a saida
# quando escreve num pipe e os eventos so chegam ao 'while read' em blocos,
# atrasando (ou parecendo travar) a atualizacao do icone.
stdbuf -oL ip monitor link | while read -r line; do
    case "$line" in
        *"$IFACE"*) sinaliza ;;
    esac
done
