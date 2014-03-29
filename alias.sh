alias copy='xsel -ib'
alias paste='xsel -b'

alias g='git'
alias open='xdg-open'
alias o='optirun'
alias ross-git-merge="git checkout master && git merge dev && git checkout dev && git push origin dev && git push origin master"
alias suspend="dbus-send --print-reply --system --dest=org.freedesktop.UPower /org/freedesktop/UPower org.freedesktop.UPower.Suspend"
alias l='ls -lah'
alias du='du -h'
alias tree="ls -R | grep \":$\" | sed -e 's/:$//' -e 's/[^-][^\/]*\//----/g' -e 's/^/   /' -e 's/-/|/'"
alias t='tmux'
alias db='dropbox'

# Making these symlinks instead so sudo may benefit.
# alias Y="yaourt"
# alias P="pacman"
# alias S="systemctl"

# These are useful with the Dvorak keyboard layout
alias 'h=l'
alias 'hs=ls'
alias 'ha=la'
alias 'hh=ll'

alias aoeu='if [ $DISPLAY ]; then setxkbmap -option grp_led:scroll -option caps:escape -option compose:ralt -layout us,dvorak; else loadkeys us; fi'
alias asdf='if [ $DISPLAY ]; then setxkbmap -option grp_led:scroll -option caps:escape -option compose:ralt -layout dvorak,us; else loadkeys dvorak; fi'

if [ -f /usr/local/bin/vimpager ]; then
	export PAGER=/usr/local/bin/vimpager
	alias less=$PAGER
	alias zless=$PAGER
fi

autoload -U edit-command-line
zle -N edit-command-line
bindkey '\C-x\C-x' edit-command-line
