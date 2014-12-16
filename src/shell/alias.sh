alias copy='xsel -ib'
alias paste='xsel -ob'

alias g='git'
alias open='xdg-open'
alias ross-git-merge="git checkout master && git merge dev && git checkout dev && git push origin dev && git push origin master"
alias suspend="dbus-send --print-reply --system --dest=org.freedesktop.UPower /org/freedesktop/UPower org.freedesktop.UPower.Suspend"
alias l='ls -lah'
alias du='du -h'

# get full path of file or dir
alias path="readlink -f"

# editing
alias e='$EDITOR'
alias se='sudo $EDITOR'

alias tmux='tmux -2'
alias t='tmux'
alias ta='tmux new-session -A -s'
alias tl='tmux list-sessions'

# Making these symlinks instead so sudo may benefit.
# alias Y="yaourt"
# alias P="pacman"
# alias S="systemctl"

alias psu="ps -u $USER"

# These are useful with the Dvorak keyboard layout
alias 'h=l'
alias 'hs=ls'
alias 'ha=la'
alias 'hh=ll'

# Easier navigation
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

# lock session
alias afk='i3lock --color=012345'

# reload shell config
alias reload='. $HOME/.${0}rc'

# Turn off caps lock
alias shh="python -c 'from ctypes import *; X11 = cdll.LoadLibrary(\"libX11.so.6\"); display = X11.XOpenDisplay(None); X11.XkbLockModifiers(display, c_uint(0x0100), c_uint(2), c_uint(0)); X11.XCloseDisplay(display)'"

# toggle dvorak/qwerty
alias aoeu='setkeys qwerty'
alias asdf='setkeys dvorak'

# fasd
alias j='fasd_cd -d'
alias jj='fasd_cd -d -i'
