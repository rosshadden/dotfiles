#!/usr/bin/env bash

################
# FUNCTIONS
################

isCommand() {
	command -v "$1" >/dev/null 2>&1
}

################
# ENV
################

# monitor blanking
xset s 3600 3600

# display+themes
[[ -f ~/.Xresources ]] && xrdb ~/.Xresources

# temp workspace
[[ -d /tmp/aoeu ]] || mkdir /tmp/aoeu

################
# UTILS
################

# numlock
numlockx &

# statusbar
# TODO: doesn't work with bpswm
# ~/bin/bars

# composite manager
isCommand picom && picom -b &

# autolock
# TODO: doesn't work with bpswm
# xss-lock -- ~/bin/locker -r

# wallpaper
feh --recursive --randomize --bg-scale ~/Dropbox/media/images/wallpaper

################
# APPS
################

# fs
isCommand dropbox && dropbox-cli start &

# chat
# isCommand pidgin && pidgin &
# isCommand slack && slack &

# copypasta
isCommand copyq && copyq &

# gestures
isCommand easystroke && easystroke &

# dunst
# TODO: this is supposed to start up automatically, and used to
isCommand dunst && dunst &

################
# LOCAL
################

[[ -f ~/local/lib/startup.sh ]] && ~/local/lib/startup.sh &
