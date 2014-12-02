#!/usr/bin/env bash

if [ "$#" -gt 0 ]; then
	layout=$1
else
	# if no arguments passed, act as a variant toggle
	layout="toggle"
fi

# NOTE: I switch layouts with `aoeu` -> qwerty and `asdf` -> dvorak
# because of the positions of the keys

# reset xcape
function resetXcape {
	pkill xcape
	xcape -e 'Control_L=Escape;Alt_R=Super_L|space'
	# TODO: the following is ideal, but depends on `caps:ctrl_modifier` working
	# xcape -e 'Caps_Lock=Escape;Alt_R=Control_L|space'
}

# load keyboard mappings
function loadMap {
	[[ -f $DOTS/X/.Xmodmap ]] && xmodmap $DOTS/X/.Xmodmap
	# [[ -f $DOTS/X/.Xkeymap ]] && xkbcomp $DOTS/X/.Xkeymap $DISPLAY
	return 0
}

if [[ $layout == "init" ]]; then
	if [ $DISPLAY ]; then
		setxkbmap \
			-layout us,us \
			-variant dvorak, \
			-option \
			-option grp_led:scroll \
			-option grp:sclk_toggle \
			-option keypad:pointerkeys \
			-option ctrl:nocaps
			# TODO: the following is ideal, but running `xmodmap` afterward breaks
			# -option caps:ctrl_modifier
		loadMap
		resetXcape
	else
		loadkeys dvorak
	fi
elif [[ $layout == "toggle" ]]; then
	if [ $DISPLAY ]; then
		xdotool key ISO_Next_Group
	fi
elif [[ $layout == "aoeu" || $layout == "dvorak" ]]; then
	# switch to dvorak
	if [ $DISPLAY ]; then
		setxkbmap -variant dvorak,
		loadMap
	else
		loadkeys dvorak
	fi
elif [[ $layout == "asdf" || $layout == "us" || $layout == "qwerty" ]]; then
	# switch to qwerty
	if [ $DISPLAY ]; then
		setxkbmap -variant ,dvorak
		loadMap
	else
		loadkeys us
	fi
else
	# switch to whatever was passed in
	if [ $DISPLAY ]; then
		setxkbmap $layout
		loadMap
	else
		loadkeys $layout
	fi
fi
