#!/usr/bin/env bash


################
# UTILITIES
################
	# composite manager
	xcompmgr -cF &

	# pulseaudio
	pulseaudio --start &


################
# CONFIG
################
	# keyboard
	~/bin/setkeys init


################
# APPS
################
	# dropbox
	dropboxd &

	# copyQ
	copyq &
