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

# aliases uteis para ls
alias l.='ls -d .* --color=auto'

# Gets external IP address.
# https://gist.github.com/kakawait/4572163
if command -v dig &> /dev/null; then
    alias publicip='dig +short myip.opendns.com @resolver1.opendns.com'
elif command -v curl > /dev/null; then
    alias publicip='curl --silent --compressed --max-time 5 --url "https://ipinfo.io/ip"'
else
    alias publicip='wget -qO- --compression=auto --timeout=5 "https://ipinfo.io/ip"'
fi

# aliases uteis para saltar entre locais ja visitados
alias dirs='dirs -v'
if [ -z $BASH ]; then
    alias -1='cd -1'
    alias -2='cd -2'
    alias -3='cd -3'
    alias -4='cd -4'
    alias -5='cd -5'
fi

# Aliases melhorar minha vida com um teclado ruim
alias suudo='sudo'
alias vimm='vim'
alias viim='vim'


# tmux randomiza escolha do tema
alias tmux='TMUXCOL=${TMUXTHEMES[$RANDOM % ${#TMUXTHEMES[@]} + 1]} tmux'
