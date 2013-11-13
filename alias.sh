alias copy='xclip -selection c'
alias paste='xclip -o -selection CLIPBOARD'

alias g='git'
alias open='xdg-open'
alias o='optirun'
alias ross-git-merge="git checkout master && git merge dev && git checkout dev && git push origin dev && git push origin master"
alias suspend="dbus-send --print-reply --system --dest=org.freedesktop.UPower /org/freedesktop/UPower org.freedesktop.UPower.Suspend"
alias l='ls -la'
alias du='du --block-size=M'
alias tree="ls -R | grep \":$\" | sed -e 's/:$//' -e 's/[^-][^\/]*\//----/g' -e 's/^/   /' -e 's/-/|/'"

autoload -U edit-command-line
zle -N edit-command-line
bindkey '\C-x\C-x' edit-command-line
