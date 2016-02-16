#!/usr/bin/env bash

# TODO: Clean up entire script


if [ "$#" -gt 0 ]; then
	action=$1
else
	# if no arguments passed, act as a getter
	action="get"
fi


# NOTE: I switch layouts with `aoeu` -> qwerty and `asdf` -> dvorak
# because of the positions of the keys


# reset xcape
function resetXcape {
	pkill xcape
	xcape -e "Control_L=Escape;Alt_L=Control_L|space;Alt_R=Super_L|space"
	# TODO: the following is more ideal, but depends on `caps:ctrl_modifier` working
	# xcape -e "Caps_Lock=Escape;Alt_R=Control_L|space"
}


# load keyboard mappings
function loadMap {
	[[ -f $DOTS/src/.Xmodmap ]] && xmodmap $DOTS/src/.Xmodmap
	return 0
}


if [[ $action == "init" ]]; then
	if [ $DISPLAY ]; then
		setxkbmap \
			-layout us,us \
			-variant ,dvorak \
			-option \
			-option grp_led:caps \
			-option grp:shifts_toggle \
			-option keypad:pointerkeys \
			-option compose:sclk \
			-option ctrl:nocaps
			# TODO: the following is ideal, but running `xmodmap` afterward breaks
			# -option caps:ctrl_modifier
		loadMap
		resetXcape
	else
		loadkeys us
	fi
elif [[ $action == "get" ]]; then
	if [ $DISPLAY ]; then
		variant=`setxkbmap -query | awk '/variant/{print $2}' | cut -d ',' -f 1`
		[[ $variant == "" ]] && variant=qwerty
		echo $variant
	fi
elif [[ $action == "toggle" ]]; then
	if [ $DISPLAY ]; then
		xdotool key ISO_Next_Group
	fi
elif [[ $action == "aoeu" || $action == "dvorak" ]]; then
	# switch to dvorak
	if [ $DISPLAY ]; then
		setxkbmap -variant dvorak,
		loadMap
	else
		loadkeys dvorak
	fi
elif [[ $action == "asdf" || $action == "us" || $action == "qwerty" ]]; then
	# switch to qwerty
	if [ $DISPLAY ]; then
		setxkbmap -variant ,dvorak
		loadMap
	else
		loadkeys us
	fi
else
	echo "Not a valid command.  Since I'm too lazy to make help text for this, you have to look in the source code."
fi
