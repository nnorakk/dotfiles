# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="${HOME}/.oh-my-zsh"

# https://github.com/ohmyzsh/ohmyzsh/issues/12328
zstyle ':omz:alpha:lib:git' async-prompt no 

# tema customizado
ZSH_THEME="refined-jp"

# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git 
    virtualenv
    zsh-autosuggestions
    docker
    docker-compose
    zsh-syntax-highlighting
    kube-ps1
    kubectl
    sudo
    history-substring-search
    z)

source $ZSH/oh-my-zsh.sh

# User configuration
#Compartilhar historicos entre terminais
setopt share_history
