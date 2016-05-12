#!/usr/bin/env bash

################
# CONFIG
################

# keyboard
# ~/bin/keys init

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
xcompmgr -cF &

################
# APPS
################

# dropbox
dropbox-cli start

# Easystroke
easystroke &

# CopyQ
copyq &

# Zeal
zeal &

# cvim external editor
~/lib/cvim-server.py &

################
# LOCAL
################

[[ -f ~/local/lib/startup.sh ]] && ~/local/lib/startup.sh
