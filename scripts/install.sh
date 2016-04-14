#!/usr/bin/env bash

function install() {
	local task=$1

	# TODO: make this an optional, defaulted argument
	local DOTS=$HOME/dotfiles

	echo "Initializing git submodules."
	git submodule update --init --remote --recursive

	echo "Linking dotfiles to $HOME"
	echo
	for file in $DOTS/src/{*,.[^.]*}; do
		local name=$(basename $file)

		if [[ "$name" == "shell" ]]; then continue; fi
		if [[ "$name" == "themes" ]]; then continue; fi
		if [[ "$name" =~ ".swp" ]]; then continue; fi

		ln -s $file $HOME/
	done
	echo

	echo "Linking config files to $XDG_CONFIG_HOME"
	ln -s $DOTS/src/.config/* $XDG_CONFIG_HOME/
}

install $1
