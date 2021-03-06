myxfreerdp() {
    machine="$1"
    if [[ "$machine" == commvault* || "$machine" == rrnwsri06* ]]; then
        print "Conectando usando ${regular_user}"
		/usr/bin/xfreerdp /size:1600x1020 /d:${domain} /u:${regular_user} /v:$machine
    else
        print "Conectando usando ${admin_user}"
		/usr/bin/xfreerdp /size:1600x1020 /d:${domain} /u:${admin_user} /v:$machine
    fi
}
alias xfreerdp=myxfreerdp

# servidores dominio antigo
# alias rdesktop='rdesktop -g 1600x1000 -u trern\\jbezerra'

# Use vim with +xterm_clipboard support if installed
if which vimx > /dev/null 2>&1; then 
		alias vim=$(which vimx) 
fi

# evita erros em maquinas remotas via ssh
alias ssh='TERM=xterm ssh'

# evita erros do hashicorp packer
# https://learn.hashicorp.com/tutorials/packer/getting-started-install
[ -f /usr/bin/packer ] && alias packer='/usr/bin/packer'

# Use lsd if installed
if which lsd > /dev/null 2>&1; then 
		alias ls='lsd'
		alias tree='lsd --tree'
        alias ltr='lsd -ltr'
fi

# Usa funcao que usa vimi como pager
alias man='manvim'

# editar arquivos sensiveis sem salvar historico
alias vimsecret='vim -c "set nobackup noswapfile noundofile"'
