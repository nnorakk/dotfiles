myxfreerdp() {
    machine="$1"
    if [[ "$machine" == "commvault" || "$machine" == "rrnwsri06" ]]; then
        print "Conectando usando ***REMOVED***"
		/usr/bin/xfreerdp /size:1600x1020 /d:tre-rn /u:***REMOVED*** /v:$machine
    else
        print "Conectando usando jpaulo"
		/usr/bin/xfreerdp /size:1600x1020 /d:tre-rn /u:jpaulo /v:$machine
    fi
}
alias xfreerdp=myxfreerdp

# servidores dominio antigo
alias rdesktop='rdesktop -g 1600x1000 -u trern\\jbezerra'

# Use vim with +xterm_clipboard support if installed
if which vimx > /dev/null 2>&1; then 
		alias vim=$(which vimx) 
fi

# evita erros em maquinas remotas via ssh
alias ssh='TERM=xterm ssh'
