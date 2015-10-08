#!/usr/bin/env bash

################
# CONFIG
################

# keyboard
~/bin/keys init


################
# ENVIRONMENT
################

mkdir /tmp/aoeu


################
# UTILITIES
################

# pulseaudio
pulseaudio --start &

# composite manager
xcompmgr -cF &


################
# DAEMONS
################

# Dropbox
dropbox-cli start


################
# APPS
################

# Easystroke
easystroke &

# CopyQ
copyq &

# Zeal
zeal &

# cvim external editor
~/lib/cvim-server.py &
