# Setup fzf
# ---------
if [[ ! "$PATH" == */home/jpaulo/.fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}/home/jpaulo/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/jpaulo/.fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "/home/jpaulo/.fzf/shell/key-bindings.zsh"
