alias copy="xsel -ib"
alias paste="xsel -ob"

# get full path of file or dir
alias path="readlink -f"

# echo previous command
# because I keep typing `k` on accident when forgetting I'm in copy-mode
alias k="fc -ln -1"

################
# SHORTCUTS
################

# alias suspend="dbus-send --print-reply --system --dest=org.freedesktop.UPower /org/freedesktop/UPower org.freedesktop.UPower.Suspend"
alias l="ls -lah"

alias psu="ps -u $USER"
alias pse="ps -e"

# Easier navigation
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."

# lock session
alias afk="i3lock --color=012345"

# Turn off caps lock
alias shh="python -c 'from ctypes import *; X11 = cdll.LoadLibrary(\"libX11.so.6\"); display = X11.XOpenDisplay(None); X11.XkbLockModifiers(display, c_uint(0x0100), c_uint(2), c_uint(0)); X11.XCloseDisplay(display)'"

# toggle dvorak/qwerty
alias aoeu="keys qwerty"
alias asdf="keys dvorak"

# fasd
alias j="fasd_cd -d"
alias jj="fasd_cd -d -i"

# get public ip
alias wimi="curl ipecho.net/plain; echo"

################
# EDITING
################

alias e="$EDITOR"
alias se="sudo $EDITOR"
alias ev="$VISUAL"
alias sev="sudo $VISUAL"

################
# APPS
################

alias open="xdg-open"

# git
# TODO: breakout.exe into a git module
alias g="git"
alias tigs="tig status"

# TODO: breakout.exe into a tmux module
alias tmux="tmux -2"
alias tl="tmux list-sessions"

alias Y="yaourt"

##
# attach to existing session, or create new
#
# @param {String} [1] - Session name.
#   Defaults to name of current directory.
##
ta() {
	tmux new-session -A -s ${1-$(basename $(pwd))}
}

##
# create a new session, joining in to an existing one
#
# @param {String} 1 - Existing session
# @param {String} 2 - New session
##
tj() {
	tmux new-session -t $1 -s $1-$2
}

################
# FUN
################

alias nyan='telnet -e ^c nyancat.dakko.us'

################
# GLOBAL
################

if [[ $(getShell) == 'zsh' ]]; then
	# yaourt --noconfirm
	alias -g YNO="--noconfirm"
fi

################
# SUFFIX
################

if [[ $(getShell) == 'zsh' ]]; then
	# clone git URLs
	alias -s git="git clone"

	# open PDFs
	alias -s pdf=evince
fi
