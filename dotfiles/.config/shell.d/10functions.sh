# seta variaveis abaixo do arquivo ~/.dotenv
# export regular_user=
# export admin_user=
# export domain=
if [ -f ~/.dotenv ]; then
	. ~/.dotenv
fi

manvim() {
    nvim -c "set ft=man | Man $1" -c 'silent! only'
}

function rdesktop() {
/usr/bin/rdesktop -u ${regular_user} -d ${domain} $1 -z -P -x m
}

function xfreerdp() {
    machine="$1"
    if [[ "$machine" == commvault* || "$machine" == rrnwsri06* ]]; then
        print "Conectando usando ${regular_user}"
        /usr/bin/xfreerdp /cert:ignore /size:1600x1020 /d:${domain} /u:${regular_user} /v:$machine /p:$(zenity --title="password" --entry --hide-text --text "Senha:") 2> /tmp/error.err

    else
        print "Conectando usando ${admin_user}"
        /usr/bin/xfreerdp /cert:ignore /size:1600x1020 /d:${domain} /u:${admin_user} /v:$machine /p:$(zenity --title="password" --entry --hide-text --text "Senha:") 2> /tmp/error.err
    fi

    grep -q 'ERRCONNECT_DNS_NAME_NOT_FOUND\|ERRCONNECT_AUTHENTICATION_FAILED' /tmp/error.err && return 127 || return 0
}
