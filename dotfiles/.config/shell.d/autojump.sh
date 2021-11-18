[[ -s /etc/profile.d/autojump.sh ]] && source /etc/profile.d/autojump.sh

if [[ $(uname) == 'Darwin' ]]; then
    [ -f $(brew --prefix)/etc/profile.d/autojump.sh ] && . $(brew --prefix)/etc/profile.d/autojump.sh
fi
