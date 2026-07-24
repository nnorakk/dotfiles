#!/bin/sh
# =====================================================================
# Status da VPN SonicWall para a waybar (Hyprland).
#
# Substitui o antigo ~/.config/polybar/openvpn-isrunning.sh (era OpenVPN,
# pingava 10.16.1.1 e tinha codigo morto). Este detecta DIRETO a interface
# do tunel NetExtender: quando a VPN sobe, o kernel cria a interface
# 'snwl_ssltunnel' com flag LOWER_UP; quando cai, a interface some.
#
# Saida em markup Pango (a waybar renderiza direto -- NAO precisa do
# polybar-shim.sh). Verde = ativa, vermelho = inativa.
#
# O polybar continua usando o script antigo, intacto.
# =====================================================================

IFACE="snwl_ssltunnel"
COR_ATIVA="#00ff7f"    # verde  -> VPN conectada
COR_INATIVA="#ff5b77"  # vermelho -> VPN desconectada

if ip -o link show "$IFACE" 2>/dev/null | grep -q "LOWER_UP"; then
    printf '<span color="%s"> VPN</span>\n' "$COR_ATIVA"
else
    printf '<span color="%s"> VPN</span>\n' "$COR_INATIVA"
fi
