if [[ -n "$WEZTERM_EXECUTABLE" || -n "$ALACRITTY_SOCKET" ]]; then
    # Fluxo WezTerm / Alacritty
    [ -n "$WEZTERM_PANE" ] && export NVIM_LISTEN_ADDRESS="/tmp/nvim$WEZTERM_PANE"

    # Path to your oh-my-zsh installation.
    export ZSH="${HOME}/.oh-my-zsh"
    # https://github.com/ohmyzsh/ohmyzsh/issues/12328
    zstyle ':omz:alpha:lib:git' async-prompt no 
    # tema customizado
    ZSH_THEME="refined-jp"
    # Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
    plugins=(git virtualenv zsh-autosuggestions docker docker-compose zsh-syntax-highlighting kube-ps1 sudo history-substring-search z)

    source $ZSH/oh-my-zsh.sh

    #Compartilhar historicos entre terminais
    setopt share_history

    for config in ${HOME}/.config/shell.d/wezterm/*.sh; do
        source ${config}
    done

    # source ${HOME}/.config/shell.d/10functions.sh
    # source ${HOME}/.config/shell.d/alias.sh
    # source ${HOME}/.config/shell.d/direnv.sh
    # source ${HOME}/.config/shell.d/exports.sh
    # source ${HOME}/.config/shell.d/fzf.sh
    # source ${HOME}/.config/shell.d/iterm_shell.sh
    # source ${HOME}/.config/shell.d/zoxide.sh

    # source ${HOME}/.config/shell.d/base16.sh
    # source ${HOME}/.config/shell.d/00oh-my-zsh.sh
    #
# Carrega configuracoes extras alias, export, etc
else
    for config in ${HOME}/.config/shell.d/*.sh; do
        source ${config}
    done
fi

source ${HOME}/.gemini_api_key.sh
