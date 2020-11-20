myxfreerdp() {
		/usr/bin/xfreerdp /size:1600x1020 /d:tre-rn /u:***REMOVED*** /v:$1
}
alias xfreerdp=myxfreerdp

# servidores dominio antigo
alias rdesktop='rdesktop -g 1600x1000 -u trern\\jbezerra'

# Use vim with +xterm_clipboard support if installed
if which vimx > /dev/null 2>&1; then 
		alias vim=$(which vimx) 
fi
