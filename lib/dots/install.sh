#!/usr/bin/env bash

dotsPath="${1:-$HOME/dotfiles}"
configPath="${XDG_CONFIG_HOME:-$HOME/.config}"

function init() {
	echo "Initializing git submodules."
	git submodule update --init --remote --recursive
}

function link() {
	echo "Linking {bin,lib} to $HOME"
	echo
		ln -s $dotsPath/{bin,lib} $HOME
	echo

	echo "Linking dotfiles to $HOME"
	echo
	for file in $dotsPath/src/{,.[^.]}*; do
		local name=$(basename $file)

		# linking blacklist
		if [[ "$name" == ".config" ]]; then continue; fi
		if [[ "$name" == "shell" ]]; then continue; fi
		if [[ "$name" == "themes" ]]; then continue; fi
		if [[ "$name" =~ ".swp" ]]; then continue; fi

		ln -s $file $HOME/
	done
	echo

	echo "Linking config files to $configPath"
	ln -s $dotsPath/src/.config/* $configPath/
}

init
link
