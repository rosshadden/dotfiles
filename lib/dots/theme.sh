#!/usr/bin/env bash

################
# dots-theme
#
# Generates theme files, using base16-builder
################

templates="shell vconsole xresources vim rofi vim-airline"
themePath="$DOTS/lib/themes"
base16="$DOTS/node_modules/base16-builder/dist/cli.js"

get() {
	echo "TODO: Get current theme"
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
	if [[ "$scheme" == "" ]]; then
		echo "TODO: Regenerate current theme"
		exit
	fi

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
	c | clean) action=clean ;;
	g | gen | generate) action=generate ;;
esac

$action "$@"
