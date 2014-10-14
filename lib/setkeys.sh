#!/usr/bin/env bash

if [ "$#" -gt 0 ]; then
	layout=$1
else
	# if no arguments passed, toggle between dvorak and qwerty
	# TODO: the ability to toggle is broken for now, though easy to fix
	layout=`setxkbmap -query | grep "layout" | cut -f 6 -d ' ' | cut -f 2 -d ','`
fi

# NOTE: I switch layouts with `aoeu` -> qwerty and `asdf` -> dvorak
# because of the positions of the keys

# reset xcape
function resetXcape {
	pkill xcape
	xcape
}

# load keyboard mappings
function loadMap {
	xmodmap $DOTS/X/.Xmodmap
}

if [[ $layout == "init" ]]; then
	setxkbmap \
		-layout us,us \
		-variant dvorak, \
		-option \
		-option grp_led:scroll \
		-option grp:sclk_toggle \
		-option ctrl:nocaps \
		-option compose:rctrl
	loadMap
	resetXcape
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
