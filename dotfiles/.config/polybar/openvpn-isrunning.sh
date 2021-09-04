#!/bin/sh

if pgrep -x "openvpn" > /dev/null 
then
    output=$(ping -q -c 2 10.16.1.1 2> /dev/null)
    rc=$?
    if [[ $rc -eq 0 ]]; then
        # processo openvpn ativo e vpn acessivel
        echo "%{F#08fee4} VPN%{F-}"
    else
        # processo openvpn ativo e vpn NAO acessivel
        echo "%{F#daa520} VPN%{F-}"
    fi
else
    # processo openvpn inativo
    echo "%{F#ff5b77} VPN%{F-}"
fi
