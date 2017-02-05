#!/usr/bin/env bash

################
# CONFIG
################

# keyboard
~/bin/keys &

################
# ENVIRONMENT
################

mkdir /tmp/aoeu &

################
# UTILS
################

# pulseaudio
pulseaudio --start &

# composite manager
compton -b &

################
# APPS
################

# fs
dropbox-cli start &

# chat
pidgin &

# copypasta
copyq &

# music
GMusicProxy &

# gestures
easystroke &

# cvim external editor
cvimServer=~/lib/vendor/mouseless/cvim_server.py
[[ -f $cvimServer ]] && $cvimServer &

################
# LOCAL
################

[[ -f ~/local/lib/startup.sh ]] && ~/local/lib/startup.sh &
