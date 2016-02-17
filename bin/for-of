#!/usr/bin/env zsh

# TODO: add option for suppressing header

##
# Run a given command from within each directory in a given list.
# If a list is piped to the function, uses this instead of the list of files in the current directory.
#
# @method for-of
# @param {Command} cmd - The command to run
#   It is given access to `$name` as the value of the current item.
# @param {Array} [...list=*] - The list to use
#   May be globs or space-separated values.
##
for-of() {
	local cmd=$1
	local section='\\n################\\n# $name\\n################'
	cmd="if [[ -d \$name ]]; then echo $section; cd \$name; $cmd; cd ../; fi"

	for-in $cmd
}

for-of "$@"
