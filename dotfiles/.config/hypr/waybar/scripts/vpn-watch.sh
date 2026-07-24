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

# sinaliza uma vez no inicio para garantir o estado correto ao logar
pkill --signal "RTMIN+${SIG}" waybar 2>/dev/null

# stdbuf -oL forca line-buffering: sem isso o 'ip monitor' bufferiza a saida
# quando escreve num pipe e os eventos so chegam ao 'while read' em blocos,
# atrasando (ou parecendo travar) a atualizacao do icone.
stdbuf -oL ip monitor link | while read -r line; do
    case "$line" in
        *"$IFACE"*) pkill --signal "RTMIN+${SIG}" waybar 2>/dev/null ;;
    esac
done
