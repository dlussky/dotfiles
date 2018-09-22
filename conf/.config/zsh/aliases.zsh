alias mocp='[ "$SSH_CLIENT" = "" ] && mocp'
alias chmodf='find . -type f -exec chmod 664 {} \;'
alias chmodd='find . -type d -exec chmod 775 {} \;'
alias ll='ls -laFh --group-directories-first --color'
alias l='ll'
alias tree="tree -vaC --dirsfirst"

function ttd() {
  date -d @$1 +'%d.%m.%Y %H:%M:%S'
}