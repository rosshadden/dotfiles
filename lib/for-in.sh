#!/usr/bin/env zsh

##
# Run a given command for each item in a given list.
# If a list is piped to the function, uses this instead of the list of files in the current directory.
#
# @method for-in
# @param {Command} cmd - The command to run
#   It is given access to `$name` as the value of the current item.
# @param {Array} [...list=*] - The list to use
#   May be globs or space-separated values.
##
for-in() {
	local args=( $@ )
	local len=${#args[@]}
	local cmd=${args[1]}
	local list=( * )

	if [[ $len > 1 ]]; then
		list=( ${args[@]:1:$len} )
	fi

	local name
	for name in $list; do
		eval $cmd
	done
}

stdin="$(ls -l /proc/self/fd/0)"
stdin="${stdin/*-> /}"

# TODO: abstract hasPipe function
if [[ "$stdin" =~ ^/dev/pts/[0-9] ]]; then
	for-in "$@"
else
	for-in "$@" $(cat -)
fi
