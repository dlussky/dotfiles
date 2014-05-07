# If not running interactively, don't do anything
[ -z "$PS1" ] && return

if [ -z "$SSH_CLIENT" ] && [ -z "$SSH_TTY" ]; then
	[ -e ~/dotfiles/notifyosd.zsh ] && . ~/dotfiles/notifyosd.zsh
fi

autoload -U colors && colors
# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTFILE=~/.history
SAVEHIST=10000
HISTSIZE=10000

zstyle ':completion:*:processes' command 'ps -ax' 
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;32'
zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:kill:*'   force-list always

setopt INC_APPEND_HISTORY
#setopt SHARE_HISTORY

alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

alias mocp='mocp -T transparent-background -C /home/dlussky/.moc/config'
alias chmodf='find . -type f -exec chmod 664 {} \;'
alias chmodd='find . -type d -exec chmod 775 {} \;'
alias ls="ls -al --color"
alias tree="tree -vaC --dirsfirst"

setopt prompt_subst
autoload -Uz vcs_info
zstyle ':vcs_info:*' stagedstr 'M' 
zstyle ':vcs_info:*' unstagedstr 'M' 
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' actionformats '%F{5}[%F{2}%b%F{3}|%F{1}%a%F{5}]%f'
zstyle ':vcs_info:*' formats \
  '%F{grey}[%F{blue}%b%F{grey}] %F{green}%c%F{green}%u%f '
zstyle ':vcs_info:git*+set-message:*' hooks git-untracked
zstyle ':vcs_info:*' enable git 
+vi-git-untracked() {
  if [[ $(git rev-parse --is-inside-work-tree 2> /dev/null) == 'true' ]] && \
    git status --porcelain | grep '??' &> /dev/null ; then
    hook_com[unstaged]+='%F{1}??%f'
  fi  
}

precmd () { vcs_info }

PROMPT='%{$bold_color$fg[green]%}%n%{$reset_color$fg[white]%}@%m ${vcs_info_msg_0_}%{$reset_color$fg[white]%}%~%{$fg[white]%}%# %{$reset_color$fg[white]%}'

bindkey ";5C" forward-word
bindkey ";5D" backward-word
