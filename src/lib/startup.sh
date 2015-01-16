#!/usr/bin/env bash


################
# UTILITIES
################
	# pulseaudio
	pulseaudio --start &

	# composite manager
	xcompmgr -cF &


################
# CONFIG
################
	# keyboard
	~/bin/setkeys init


################
# APPS
################
	# Dropbox
	dropboxd &

	# CopyQ
	copyq &

	# Zeal
	zeal &

	# cvim external editor
	~/lib/cvim-server.py &
