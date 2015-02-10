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
	~/bin/keys init


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
