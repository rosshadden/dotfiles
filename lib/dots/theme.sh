#!/usr/bin/env bash

################
# dots-theme
#
# Generates theme files, using base16-builder
################

templates="dunst gtk-2.0 gtk-3.0 i3 nvim rofi shell termite vconsole vim vim-airline xresources"
themeFile="$DOTS/THEME"
themePath="$DOTS/lib/themes"
base16="$DOTS/node_modules/.bin/base16-builder"

get() {
	cat "$themeFile"
}

set() {
	local scheme="$1"
	echo "$scheme" > "$themeFile"
}

list() {
	local type="${1:-templates}"
	$base16 ls "$type"
}

clean() {
	for template in $templates; do
		rm -f "$themePath/$template"
	done
}

generateTheme() {
	local scheme="$1"
	local template="$2"
	local templatePath="$themePath/$template"

	echo "Building '$scheme' for '$template', at '$templatePath'"
	$base16 -b dark -s "$scheme" -t "$template" > "$templatePath"
}

generate() {
	local scheme="$1"
	local template="$2"

	# Regenerate current theme
	if [[ "$scheme" == "" ]]; then scheme="$(get)"; fi

	set "$scheme"

	# Generate themes for all templates
	if [[ "$template" == "" ]]; then
		for template in $templates; do
			generateTheme "$scheme" "$template"
		done
		exit
	fi

	# Generate themes for specific templates
	generateTheme "$scheme" "$template"
}

action="${1:-get}"
shift

case "$action" in
	get) action=get ;;
	set) action=set ;;
	l | ls | list) action=list ;;
	c | clean) action=clean ;;
	g | gen | generate) action=generate ;;
esac

$action "$@"
