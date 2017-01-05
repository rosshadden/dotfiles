#!/usr/bin/env bash

# TODO: add docs

# Colored man pages
man() {
	env \
		LESS_TERMCAP_mb=$'\E[01;31m' \
		LESS_TERMCAP_md=$'\E[01;38;5;74m' \
		LESS_TERMCAP_me=$'\E[0m' \
		LESS_TERMCAP_se=$'\E[0m' \
		LESS_TERMCAP_so=$'\E[38;5;246m' \
		LESS_TERMCAP_ue=$'\E[0m' \
		LESS_TERMCAP_us=$'\E[04;38;5;146m' \
	man "$@"
}

# alt-left and alt-up to navigate directories
cdUndoKey() {
	popd      > /dev/null
	zle       reset-prompt
	echo
	ls
	echo
}
cdParentKey() {
	pushd .. > /dev/null
	zle      reset-prompt
	echo
	ls
	echo
}

# copy() {
# 	local output
# 	while read line; do
# 		output="${output}\n${line}"
# 	done
# 	echo $output
# 	# xsel -ib
# }

# paste() {
# 	xsel -ob
# }

error() {
	echo "$1" 1>&2
	exit 1
}

calc() {
	echo "$1" | bc -l
}

isCommand() {
	command -v $1 >/dev/null 2>&1
}

color() {
	stdin="$(ls -l /proc/self/fd/0)"
	stdin="${stdin/*-> /}"
	format=ansi
	format=xterm256

	highlight -O $format "$@"

	# TODO: make work with pipes again
	# # TODO: abstract hasPipe function
	# if [[ "$stdin" =~ ^/dev/pts/[0-9] ]]; then
	# 	highlight -O $format "$@"
	# else
	# 	echo "$(cat -)" | highlight -O $format
	# fi
}

##
# Get current shell
#
# @return {String} - Current shell
#
getShell() {
	ps -o fname --no-headers $$
}

# reload shell config
reload() {
	. $HOME/.$(getShell)rc
}

set-prompt() {
	local color=$1
	local shape=$2

	local prefix=""
	local suffix=""

	if [ $TMUX ]; then
		local prefix="\033Ptmux;\033"
		local suffix="\033\\"
	fi

	# color
	echo -ne "${prefix}\033]12;$color\007${suffix}"

	# shape
	echo -ne "${prefix}\033[$shape q${suffix}"
}

countdown() {
	date1=$((`date +%s` + $1));
	while [ "$date1" -ne `date +%s` ]; do
		echo -ne "$(date -u --date @$((`date +%s` - $date1)) +%H:%M:%S)\r";
	done
}

stopwatch() {
	date1=`date +%s`;
	while true; do
		echo -ne "\r$(date -u --date @$((`date +%s` - $date1)) +%H:%M:%S)";
	done
}

panewrap() {
	printf "\033]2;%s\033\\" "$1"; "$@";
}

# find symlinks in input list
getSymlinks() {
	find $1 -maxdepth 1 -type l
}

toJSON() {
	while read foo; do
		echo $foo | json | pygmentize -l json
	done
}

##
# Sign public AUR key
#
# @param {String} key - Public key to sign
##
signKey() {
	# TODO: see if the two `pacman-key` steps can be combined
	sudo pacman-key -r $1
	sudo pacman-key --lsign-key $1
	gpg --keyserver pgp.mit.edu --recv-keys $1
}
