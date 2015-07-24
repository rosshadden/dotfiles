#!/usr/bin/env bash

################################
# Get/set config settings
#
# Dependencies:
# - ponymix
# - xbacklight
# - synclient
################################

# TODO: normalize settings (vol -> volume, etc.)
# TODO: refactor using better organization than nested conditionals

setting="$1"
value="$2"

# recursively call itself
config() {
	$0 "$@"
}

normalizeValue() {
	local value=$1

	[[ $value == '!' ]] && local value='toggle'

	echo $value
}

value=$(normalizeValue $value)

if [[ $setting == 'volume' ]]; then
	if [[ ! $value ]]; then
		ponymix get-volume
	else
		[[ $value == 'on' ]] && value='unmute'
		[[ $value == 'off' ]] && value='mute'

		if [[ ${value:0:1} == '+' ]]; then
			ponymix increase ${value:1}
		elif [[ ${value:0:1} == '-' ]]; then
			ponymix decrease ${value:1}
		elif [[ 'toggle mute unmute' =~ $value ]]; then
			ponymix toggle
		else
			ponymix set-volume $value
		fi
	fi
elif [[ $setting == 'brightness' ]]; then
	if [[ ! $value ]]; then
		xbacklight -get
	else
		if [[ ${value:0:1} == '+' ]]; then
			xbacklight -inc ${value:1}
		elif [[ ${value:0:1} == '-' ]]; then
			xbacklight -dec ${value:1}
		else
			xbacklight -set $value
		fi
	fi
elif [[ $setting == 'touchpad' ]]; then
	if [[ ! $value ]]; then
		synclient -l | grep "TouchpadOff .*=.*0"
	else
		if [[ $value == 'toggle' ]]; then
			if [[ $(synclient -l | grep "TouchpadOff .*=.*0") ]]; then
				config touchpad 'off'
			else
				config touchpad 'on'
			fi
		elif [[ $value == 'on' ]]; then
			synclient TouchpadOff=0;
		elif [[ $value == 'off' ]]; then
			synclient TouchpadOff=1;
		fi
	fi
fi
