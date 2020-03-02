# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific environment
PATH="$HOME/.local/bin:$HOME/bin:$PATH"
export PATH

# User specific aliases and functions
alias rdesktop='rdesktop -g 1600x1000 -u trern\\jbezerra'
alias mydotfiles='git --git-dir=$HOME/.my-dotfiles/ --work-tree=$HOME'

myxfreerdp() {
		xfreerdp /size:1600x1020 /d:tre-rn /u:***REMOVED*** /v:$1
}
alias xfreerdp=myxfreerdp

# Set vim for default editor
if $(hash vim 2> /dev/null); then
    export EDITOR=vim
fi

# Use vim with +xterm_clipboard support if installed
if which vimx > /dev/null 2>&1; then 
		alias vim=$(which vimx) 
fi

# powerline
if [ -f `which powerline-daemon` ]; then
  powerline-daemon -q
  POWERLINE_BASH_CONTINUATION=1
  POWERLINE_BASH_SELECT=1
  . /usr/share/powerline/bash/powerline.sh
fi

# Apos 'dnf install fzf' deve-se fazer:
# git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
# ~/.fzf/install
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# customizacao cores de foco do pane tmux
if [ ! -z "$TMUX" ]; then
    tmux set-option window-active-style 'bg=terminal'
    tmux set-option window-style 'bg=#333333'
fi

# Base16 Shell
BASE16_SHELL="$HOME/.config/base16-shell/"
[ -n "$PS1" ] && \
    [ -s "$BASE16_SHELL/profile_helper.sh" ] && \
        eval "$("$BASE16_SHELL/profile_helper.sh")"
