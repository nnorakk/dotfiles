# Define URI padrao ao usar o comando virsh do kvm
export LIBVIRT_DEFAULT_URI="qemu:///system" 

# Startup python console
export PYTHONSTARTUP=~/.pythonrc

# Define o tamanho do historico
export HISTSIZE=100000

# Editor
export EDITOR=vim

# Adiciona .loca/bin ao PATH
export PATH=$PATH:$HOME/.local/bin:$HOME/bin

# 256 cores
export TERM='xterm-256color'

# formato 24h
export LC_TIME=en_GB.UTF-8

# fzf ignorar arquivos ignorados pelo .gitignore
if which fd > /dev/null 2>&1; then 
    export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
fi
