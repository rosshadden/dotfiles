#!/usr/bin/env bash

isCommand() {
	command -v "$1" >/dev/null 2>&1
}

################
# ENV
################

# keyboard
[[ -f ~/bin/keys ]] && ~/bin/keys

[[ -d /tmp/aoeu ]] || mkdir /tmp/aoeu

################
# UTILS
################

# pulseaudio
isCommand pulseaudio && pulseaudio --start &

# composite manager
isCommand compton && compton -b &

################
# APPS
################

# fs
isCommand dropbox&& dropbox-cli start &

# chat
isCommand pidgin && pidgin &
isCommand scudcloud && scudcloud &

# copypasta
isCommand copyq && copyq &

# music
isCommand mopidy && systemctl --user start mopidy.service &
isCommand GMusicProxy && GMusicProxy &

# gestures
isCommand easystroke && easystroke &

################
# LOCAL
################

[[ -f ~/local/lib/startup.sh ]] && ~/local/lib/startup.sh &
