alias mocp='[ "$SSH_CLIENT" = "" ] && mocp'
alias chmodf='find . -type f -exec chmod 664 {} \;'
alias chmodd='find . -type d -exec chmod 775 {} \;'
alias ll='ls -laFh --group-directories-first --color'
alias l='ll'
alias tree="tree -vaC --dirsfirst"
alias ping="fping -lp500"
function ttd() {
  date -d @$1 +'%d.%m.%Y %H:%M:%S'
}

alias optijpg='find . -name "*.jpg" | xargs mogrify -auto-orient -resize 50%'

function blamedelete() {
  for commit in $(git log --pretty='%H'); do
    git diff -U0 --ignore-space-change "$commit^" "$commit" | grep '^-.*$0' > /dev/null && echo "$commit"
  done
}
