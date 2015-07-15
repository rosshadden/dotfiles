alias copy='xsel -ib'
alias paste='xsel -ob'

# alias suspend="dbus-send --print-reply --system --dest=org.freedesktop.UPower /org/freedesktop/UPower org.freedesktop.UPower.Suspend"
alias l='ls -lah'
alias du='du -h'

# get full path of file or dir
alias path='readlink -f'

# echo previous command
# because I keep typing `k` on accident when forgetting I'm in copy-mode
alias k='fc -ln -1'


################
# APPS
################

alias open='xdg-open'

# git
# TODO: breakout.exe into a git module
alias g='git'
alias tigs='tig status'


################
# EDITING
################

alias e='$EDITOR'
alias se='sudo $EDITOR'
alias eg='gvim'
alias seg='sudo gvim'

# TODO: breakout.exe into a tmux module
alias tmux='tmux -2'
alias tl='tmux list-sessions'
alias ta='tmux new-session -A -s'
tj() {
	tmux new-session -t $1 -s $1-$2
}

alias t='task'

# Shortcuts
alias Y="yaourt"
# Making these symlinks instead so sudo may benefit.
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
alias reload='. $HOME/.`echo $0 | sed "s:-::"`rc'

# Turn off caps lock
alias shh="python -c 'from ctypes import *; X11 = cdll.LoadLibrary(\"libX11.so.6\"); display = X11.XOpenDisplay(None); X11.XkbLockModifiers(display, c_uint(0x0100), c_uint(2), c_uint(0)); X11.XCloseDisplay(display)'"

# toggle dvorak/qwerty
alias aoeu='keys qwerty'
alias asdf='keys dvorak'

# fasd
alias j='fasd_cd -d'
alias jj='fasd_cd -d -i'

# get public ip
alias wimi='curl ipecho.net/plain; echo'


################
# SUFFIX
################

# clone git URLs
alias -s git='git clone'

# open PDFs
alias -s pdf=evince
