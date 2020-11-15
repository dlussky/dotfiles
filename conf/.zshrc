# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# If running locally - enable notify on long commands
if [ -z "$SSH_CLIENT" ] && [ -z "$SSH_TTY" ]; then
	[ -e ~/dotfiles/misc/notifyosd.zsh ] && . ~/dotfiles/misc/notifyosd.zsh
fi

# Oh-my-zsh!
ZSH_THEME="agnoster"
plugins=(gitfast tmux common-aliases command-not-found composer dirhistory systemd)

export ZSH=$HOME/.oh-my-zsh
export ZSH_CUSTOM=$HOME/.config/oh-my-zsh
COMPLETION_WAITING_DOTS="true"
. $ZSH/oh-my-zsh.sh

# History options
HISTFILE=~/.history
SAVEHIST=500000
HISTSIZE=500000
HIST_STAMPS="dd.mm.yyyy"

setopt HIST_VERIFY
setopt INC_APPEND_HISTORY
setopt HIST_IGNORE_SPACE
setopt SHARE_HISTORY
setopt hist_ignore_all_dups

# Misc options 
LESS="-RFX"

# Compose bin path
if [ -d "$HOME/.config/composer/vendor/bin" ] ; then
  PATH="$HOME/.config/composer/vendor/bin:$PATH"
fi

if [ -d "$HOME/.local/bin" ] ; then
  PATH="$HOME/.local/bin:$PATH"
fi


# Custom configs
export CUSTOM_CONFIGS_DIR=$HOME/.config/zsh

. $CUSTOM_CONFIGS_DIR/dir-colors.zsh
. $CUSTOM_CONFIGS_DIR/completion-settings.zsh
. $CUSTOM_CONFIGS_DIR/aliases.zsh

# system-specific aliases
if [ -f "$CUSTOM_CONFIGS_DIR/custom-aliases.zsh" ] ; then
  . $CUSTOM_CONFIGS_DIR/custom-aliases.zsh
fi
