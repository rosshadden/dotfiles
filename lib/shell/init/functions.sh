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

hasPipe() {
	stdin="$(ls -l /proc/self/fd/0)"
	stdin="${stdin/*-> /}"
	if [[ "$stdin" =~ /dev/pts ]]; then return 1; fi
}

dupe() {
	local direction="$1"
	local dir="$2"
	shift 2
	local files=( "$@" )

	for file in "${files[@]}"; do
		if [[ "$direction" = "to" ]]; then
			cp -r {,"$dir/"}"$file"
		elif [[ "$direction" = "from" ]]; then
			cp -r {"$dir/",}"$file"
		fi
	done
}

trim() {
	if hasPipe; then
		echo -n "$(cat)"
	else
		echo -n "$1"
	fi
}

put() {
	local flags="${1:--b}"

	if isCommand xsel; then
		xsel -o $flags
	elif isCommand pbpaste; then
		pbpaste
	fi
}

error() {
	echo "$1" 1>&2
	exit 1
}

calc() {
	echo "$1" | bc -l
}

isCommand() {
	command -v "$1" >/dev/null 2>&1
}

##
# Get current shell
#
# @return {String} - Current shell
#
getShell() {
	ps -p "$$" -ocomm= | sed 's;^/.*/;;'
}

# reload shell config
reload() {
	. $HOME/.$(getShell)rc
}

isTmux() {
	[ -n "$TMUX" ]
}

##
# Attach to existing session, or create new.
# If inside a session already, rename it.
#
# @param {String} [name] - Session name.
#   Defaults to name of current directory.
##
ta() {
	local name=${1-$(basename "$(pwd)")}
	if isTmux; then
		tmux rename-session "$name"
		echo "Renaming session to: $name"
	else
		tmux -u new-session -A -s "$name"
	fi
}

##
# Attach to existing session using fzf'd list
#
# @param {String} [name] - Existing session
##
tj() {
	local name="$1"
	if [ "$name" ]; then
		ta "name"
	else
		ta $(tmux list-sessions -F '#{session_name}' | fzf)
	fi
}

fzff() {
  cat | fzf --query "$1" --select-1 --exit-0
}

set-prompt() {
	local color=$1
	local shape=$2

	local prefix=""
	local suffix=""

	if isTmux; then
		local prefix="\033Ptmux;\033"
		local suffix="\033\\"
	fi

	# color
	echo -ne "${prefix}\033]12;$color\007${suffix}"

	# shape
	echo -ne "${prefix}\033[$shape q${suffix}"
}

countdown() {
	date1=$(($(date +%s) + $1));
	while [ "$date1" -ne "$(date +%s)" ]; do
		echo -ne "$(date -u --date @$(($(date +%s) - date1)) +%H:%M:%S)\r";
	done
}

stopwatch() {
	date1=$(date +%s);
	while true; do
		echo -ne "\r$(date -u --date @$(($(date +%s) - date1)) +%H:%M:%S)";
	done
}

panewrap() {
	printf "\033]2;%s\033\\" "$1"; "$@";
}

# find symlinks in input list
getSymlinks() {
	find "$1" -maxdepth 1 -type l
}

##
# Sign public AUR key
#
# @param {String} key - Public key to sign
##
signKey() {
	# TODO: see if the two `pacman-key` steps can be combined
	sudo pacman-key -r "$1"
	sudo pacman-key --lsign-key "$1"
	gpg --recv-keys "$1"
}

trickPython() {
	ln -s "$(which python2)" /tmp/aoeu/python
	export PATH=/tmp/aoeu:$PATH
}

fixBluetooth() {
	local index=$(pacmd list-cards | pt 'name: <bluez' -B 1 | head -1 | sed -E 's;^.*index: (.+);\1;')
	pacmd set-card-profile "$index" off && pacmd set-card-profile "$index" a2dp_sink
}
