#!/usr/bin/env bash

if [ "$#" -gt 0 ]; then
	layout=$1
else
	# if no arguments passed, toggle between dvorak and qwerty
	# TODO: the ability to toggle is broken for now, though easy to fix
	layout=`setxkbmap -query | grep "layout" | cut -f 6 -d ' ' | cut -f 2 -d ','`
fi

# note that the reason I switch layouts with `aoeu` -> qwerty and `asdf` -> dvorak
# is because of the positions of the keys

if [[ $layout == "init" ]]; then
	setxkbmap \
		-layout us,us \
		-variant dvorak, \
		-option \
		-option grp_led:scroll \
		-option caps:escape \
		-option grp:sclk_toggle \
		-option compose:rctrl
	# xmodmap $DOTS/X/.Xmodmap
elif [[ $layout == "aoeu" || $layout == "dvorak" ]]; then
	# switch to dvorak
	if [ $DISPLAY ]; then
		setxkbmap -variant dvorak,
	else
		loadkeys dvorak
	fi
elif [[ $layout == "asdf" || $layout == "us" || $layout == "qwerty" ]]; then
	# switch to qwerty
	if [ $DISPLAY ]; then
		setxkbmap -variant ,dvorak
	else
		loadkeys us
	fi
else
	# switch to whatever was passed in
	if [ $DISPLAY ]; then
		setxkbmap $layout
	else
		loadkeys $layout
	fi
fi
