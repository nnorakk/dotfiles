#!/usr/bin/env zsh

# ------------------------------------------------------------------------------
#
# Pure - A minimal and beautiful theme for oh-my-zsh
#
# Based on the custom Zsh-prompt of the same name by Sindre Sorhus. A huge
# thanks goes out to him for designing the fantastic Pure prompt in the first
# place! I'd also like to thank Julien Nicoulaud for his "nicoulaj" theme from
# which I've borrowed both some ideas and some actual code. You can find out
# more about both of these fantastic two people here:
#
# Sindre Sorhus
#   Github:   https://github.com/sindresorhus
#   Twitter:  https://twitter.com/sindresorhus
#
# Julien Nicoulaud
#   Github:   https://github.com/nicoulaj
#   Twitter:  https://twitter.com/nicoulaj
#
# ------------------------------------------------------------------------------
 
ZSH_THEME_VIRTUAL_ENV_PROMPT_PREFIX="%{$fg[green]%}‹"
ZSH_THEME_VIRTUAL_ENV_PROMPT_SUFFIX="› %{$reset_color%}"
ZSH_THEME_VIRTUALENV_PREFIX=$ZSH_THEME_VIRTUAL_ENV_PROMPT_PREFIX
ZSH_THEME_VIRTUALENV_SUFFIX=$ZSH_THEME_VIRTUAL_ENV_PROMPT_SUFFIX

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[blue]%}[ "
# ZSH_THEME_GIT_PROMPT_SUFFIX="%{$fg_bold[blue]%}]{$reset_color%}"
ZSH_THEME_GIT_PROMPT_SUFFIX=""
# ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%} %{$fg[green]%}✔%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN=""
ZSH_THEME_GIT_PROMPT_DIRTY=""
#
# ZSH_THEME_GIT_PROMPT_ADDED="%{$fg[green]%}] ✚"
ZSH_THEME_GIT_PROMPT_ADDED="%{$fg[green]%}✚%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_MODIFIED="%{$fg[green]%}✹%{$reset_color%}" # %{$reset_color%}{$fg_bold[blue]%}]{$reset_color%}"
# ZSH_THEME_GIT_PROMPT_MODIFIED="%{$fg[blue]%} ✹ "
ZSH_THEME_GIT_PROMPT_DELETED="%{$fg[red]%}✖%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_RENAMED="%{$fg[magenta]%}➜%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_UNMERGED="%{$fg[yellow]%}═%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[red]%}✭%{$reset_color%}"

local venv_prompt='$(virtualenv_prompt_info)'

# Set required options
#
setopt prompt_subst

# Load required modules
#
autoload -Uz vcs_info

# Fastest possible way to check if repo is dirty
#
git_dirty() {
    # Check if we're in a git repo
    command git rev-parse --is-inside-work-tree &>/dev/null || return
    # Check if it's dirty
    command git diff --quiet --ignore-submodules HEAD &>/dev/null; [ $? -eq 1 ] && echo "*"
}

# Display information about the current repository
#
repo_information() {
    if [[ -n $(git_prompt_status) ]]; then
        echo "$(git_prompt_info) $(git_prompt_status)%{$fg[blue]%}]"
    elif [[ -n $(git_prompt_info) ]]; then
        echo "$(git_prompt_info)]"
    fi
}

# Displays the exec time of the last command if set threshold was exceeded
#
cmd_exec_time() {
    local stop=`date +%s`
    local start=${cmd_timestamp:-$stop}
    let local elapsed=$stop-$start
    # [ $elapsed -gt 5 ] && echo ${elapsed}s
    [ $elapsed -gt 5 ] && echo $(show_time ${elapsed})
}

show_time() {
    segundos="$1"
    if ((segundos>59)); then
        minutos=$((segundos/60))
        segundos=$((segundos%60))
        if ((minutos>59)); then
            horas=$((minutos/60))
            minutos=$((minutos%60))
            if ((horas>23)); then
                dias=$((horas/24))
                horas=$((horas%24))
                echo "${dias}d ${horas}h ${minutos}m"
            else
                echo "${horas}h ${minutos}m"
            fi
        else
            echo "${minutos}m ${segundos}s"
        fi
    else
        echo "${segundos}s"
    fi
}

# Get the initial timestamp for cmd_exec_time
#
preexec() {
    cmd_timestamp=`date +%s`
}

# Output additional information about paths, repos and exec time
#
precmd() {
    vcs_info # Get version control info before we start outputting stuff
    print -P "\n${venv_prompt}$(repo_information)%F{blue} %F{yellow}$(cmd_exec_time)%f"
    # print -P "\n%F{yellow}$(cmd_exec_time)%f"
    unset cmd_timestamp #Reset cmd exec time.
}

# Define prompts
#
# PROMPT="%F{8}${SSH_TTY:+%n@%m}%f%(?.%F{green}.%F{red})❯%f " # Display a red prompt char on failure
PROMPT="%F{8}${SSH_TTY:+%n@%m}%f%F{blue}%1~ %(?.%F{green}.%F{red})❯%f " # Display a red prompt char on failure
RPROMPT='%{$FG[242]%}%5~%{$reset_color%} '

# ------------------------------------------------------------------------------
#
# List of vcs_info format strings:
#
# %b => current branch
# %a => current action (rebase/merge)
# %s => current version control system
# %r => name of the root directory of the repository
# %S => current path relative to the repository root directory
# %m => in case of Git, show information about stashes
# %u => show unstaged changes in the repository
# %c => show staged changes in the repository
#
# List of prompt format strings:
#
# prompt:
# %F => color dict
# %f => reset color
# %~ => current path
# %* => time
# %n => username
# %m => shortname host
# %(?..) => prompt conditional - %(condition.true.false)
#
# ------------------------------------------------------------------------------
