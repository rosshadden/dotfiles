#!/usr/bin/env zsh

# TODO: allow options for files/folders/symlinks only (or mandate globs, which support this)
# TODO: flip args so the last ones are the filter args
# TODO: |--> handle pipes
for-in() {
	local args=( $@ )
	local len=${#args[@]}
	local cmd=${args[1]}
	local filter=( * )

	if [[ $len > 1 ]]; then
		filter=( ${args[@]:1:$len} )
	fi

	local name
	for name in $filter; do
		eval $cmd
	done
}

stdin="$(ls -l /proc/self/fd/0)"
stdin="${stdin/*-> /}"

if [[ "$stdin" =~ ^/dev/pts/[0-9] ]]; then
	for-in "$@"
else
	for-in "$@" $(cat -)
fi
