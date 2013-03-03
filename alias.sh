alias copy='xclip -selection c'
alias paste='xclip -o -selection CLIPBOARD'

alias g='git'
alias o='optirun'
alias ross-git-merge="git checkout master && git merge dev && git checkout dev && git push origin dev && git push origin master"
alias suspend="dbus-send --print-reply --system --dest=org.freedesktop.UPower /org/freedesktop/UPower org.freedesktop.UPower.Suspend"

alias ross="~/Dropbox/.dots/r.js"
