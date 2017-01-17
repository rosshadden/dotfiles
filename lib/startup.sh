#!/usr/bin/env bash

################
# CONFIG
################

# keyboard
~/bin/keys

################
# ENVIRONMENT
################

mkdir /tmp/aoeu

################
# UTILS
################

# pulseaudio
pulseaudio --start &

# composite manager
compton -b

################
# APPS
################

# dropbox
dropbox-cli start

# easystroke
easystroke &

# copyQ
copyq &

# pidgin
pidgin &

gitter &

# google music proxy
GMusicProxy &

# cvim external editor
# ~/lib/cvim-server.py &

################
# LOCAL
################

[[ -f ~/local/lib/startup.sh ]] && ~/local/lib/startup.sh
