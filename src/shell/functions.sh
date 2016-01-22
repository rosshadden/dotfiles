#!/usr/bin/env bash

# TODO: add docs

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

# TODO: allow options for files/folders/symlinks only (or mandate globs, which support this)
for-in() {
	local args=( $@ )
	local len=${#args[@]}
	local cmd=${args[$len]}
	local filter=( * )

	if [[ $len > 1 ]]; then
		filter=( ${args[@]:0:$len - 1} )
	fi

	local name
	for name in $filter; do
		eval $cmd
	done
}

# TODO: add option for suppressing header
for-of() {
	local args=( $@ )
	local len=${#args[@]}

	local section='\\n################################\\n# $name\\n################################'
	args[$len]="if [[ -d \$name ]]; then echo $section; cd \$name; ${args[$len]}; cd ../; fi"

	for-in $args
}

calc() {
	echo "$1" | bc -l
}

isCommand() {
	command -v $1 >/dev/null 2>&1
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
