#!/usr/bin/env bash

DOTS=$1

function init() {
	echo "Initializing git submodules."
	git submodule update --init --remote --recursive
}

function link() {
	echo "Linking dotfiles to $HOME"
	echo
	for file in $DOTS/src/{*,.[^.]*}; do
		local name=$(basename $file)

		# linking blacklist
		if [[ "$name" == "shell" ]]; then continue; fi
		if [[ "$name" == "themes" ]]; then continue; fi
		if [[ "$name" =~ ".swp" ]]; then continue; fi

		ln -s $file $HOME/
	done
	echo

	echo "Linking config files to $XDG_CONFIG_HOME"
	ln -s $DOTS/src/.config/* $XDG_CONFIG_HOME/
}

init
link
