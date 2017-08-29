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
systemctl --user start mopidy.service &
GMusicProxy &

# gestures
easystroke &

################
# LOCAL
################

[[ -f ~/local/lib/startup.sh ]] && ~/local/lib/startup.sh &
