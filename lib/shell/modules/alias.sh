#!/usr/bin/env bash

# get full path of file or dir
alias path="readlink -f"

# echo previous command
# because I keep typing `k` on accident when forgetting I'm in copy-mode
alias k="fc -ln -1"

################
# SHORTCUTS
################

# alias suspend="dbus-send --print-reply --system --dest=org.freedesktop.UPower /org/freedesktop/UPower org.freedesktop.UPower.Suspend"
alias ls="ls -G --color"
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

# get public ip
alias wimi="curl ipecho.net/plain; echo"

alias today="date +%Y-%m-%d"

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
alias tigr="tig \$(g rev-parse HEAD)..\$(g rev-parse FETCH_HEAD)"
alias tigr-="tigr --no-merges"

# TODO: breakout.exe into a tmux module
alias tmux="tmux -2"
alias tl="tmux list-sessions"

if isTmux; then
	alias weechat="TERM=tmux-256color weechat"
fi

################
# FUN
################

if [[ -f "/usr/bin/nc" ]]; then
	alias nyan='nc -v nyancat.dakko.us 23' # nyan cat
elif [[ -f /usr/bin/telnet ]]; then
	alias nyan='telnet -e ^c nyancat.dakko.us'
fi

################
# SUFFIX
################

if [[ "$(getShell)" == "zsh" ]]; then
	# clone git URLs
	alias -s git="git clone"

	# open PDFs
	alias -s pdf="evince"
fi
