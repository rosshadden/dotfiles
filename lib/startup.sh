#!/usr/bin/env bash

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

# keyboard
[[ -f ~/bin/keys ]] && ~/bin/keys

# temp workspace
[[ -d /tmp/aoeu ]] || mkdir /tmp/aoeu

################
# UTILS
################

numlockx &

# composite manager
isCommand compton && compton -b &

################
# APPS
################

# fs
isCommand dropbox && dropbox-cli start &

# chat
isCommand pidgin && pidgin &
isCommand slack && slack &

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
