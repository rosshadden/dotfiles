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

# google music proxy
GMusicProxy &

# cvim external editor
cvimServer=~/lib/vendor/mouseless/cvim_server.py
[[ -f $cvimServer ]] && $cvimServer &

################
# LOCAL
################

[[ -f ~/local/lib/startup.sh ]] && ~/local/lib/startup.sh
