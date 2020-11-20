# integracao com iterm
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# Ctrl-U nao deleta da posicao do curso ate inicio da linha no iterm2
bindkey \^U backward-kill-line
