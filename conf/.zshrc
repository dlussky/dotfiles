# If not running interactively, don't do anything
[ -z "$PS1" ] && return


if [ -z "$SSH_CLIENT" ] && [ -z "$SSH_TTY" ]; then
	[ -e ~/dotfiles/misc/notifyosd.zsh ] && . ~/dotfiles/misc/notifyosd.zsh
fi

source ~/dotfiles/misc/dir_colors.zsh

zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*:processes' command 'ps -ax' 
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;32'
zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:kill:*'   force-list always

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


export ZSH=$HOME/.oh-my-zsh
plugins=(git, common-aliases)

HISTFILE=~/.history
SAVEHIST=50000
HISTSIZE=50000

setopt HIST_VERIFY
setopt INC_APPEND_HISTORY
setopt HIST_IGNORE_SPACE
setopt SHARE_HISTORY
setopt hist_ignore_all_dups


if [ -d "$HOME/.composer/vendor/bin" ] ; then
  PATH="$HOME/.composer/vendor/bin:$PATH"
fi

export PATH=$HOME/bin:/usr/local/bin:$PATH


source $ZSH/oh-my-zsh.sh


LESS="-RFX"


alias tm='tmux a'

alias mocp='[ "$SSH_CLIENT" = "" ] && mocp -T transparent-background -C /home/dlussky/.moc/config'
alias chmodf='find . -type f -exec chmod 664 {} \;'
alias chmodd='find . -type d -exec chmod 775 {} \;'
alias ll='ls -laFh --group-directories-first --color'
alias l='ll'
alias tree="tree -vaC --dirsfirst"

function merge() {
  git stash && git checkout master && git pull && echo "=== PULL      [OK]" && git checkout - && git merge master && echo "=== MERGE     [OK]" && ~/confirm "POP-POP? [y/N]" && git stash pop
}

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

PROMPT='%{$fg_bold[green]%}%n%{$fg_no_bold[white]%}@%m ${vcs_info_msg_0_}%{$fg[white]%}%~ %{$fg[green]%}𝄞 %{$reset_color%}'

bindkey ";5C" forward-word
bindkey ";5D" backward-word

if [ -d "$HOME/.composer/vendor/bin" ] ; then
  PATH="$HOME/.composer/vendor/bin:$PATH"
fi
