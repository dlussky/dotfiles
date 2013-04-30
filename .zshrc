# If not running interactively, don't do anything
[ -z "$PS1" ] && return

[ -e ~/dotfiles/notifyosd.zsh ] && . ~/dotfiles/notifyosd.zsh

autoload -U colors && colors
# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTFILE=~/.history
SAVEHIST=10000
HISTSIZE=10000

setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY

alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

alias mocp='mocp -T transparent-background'
alias chmodf='find . -type f -exec chmod 664 {} \;'
alias chmodd='find . -type d -exec chmod 775 {} \;'
alias ls="ls -al --color"

PS1="%{$bold_color$fg[green]%}%n%{$bold_color$fg[white]%}@%m %{$reset_color$fg[white]%}%~%{$bold_color$fg[white]%}%# %{$reset_color$fg[white]%}"

bindkey ";5C" forward-word
bindkey ";5D" backward-word
