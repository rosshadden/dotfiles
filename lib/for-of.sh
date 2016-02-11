#!/usr/bin/env zsh

# TODO: add option for suppressing header
for-of() {
	local args=( $@ )
	local len=${#args[@]}

	local section='\\n################################\\n# $name\\n################################'
	args[1]="if [[ -d \$name ]]; then echo $section; cd \$name; ${args[1]}; cd ../; fi"

	if [[ "$stdin" =~ ^/dev/pts/[0-9] ]]; then
		for-in $args
	else
		for-in $args[1]
	fi
}

stdin="$(ls -l /proc/self/fd/0)"
stdin="${stdin/*-> /}"

if [[ "$stdin" =~ ^/dev/pts/[0-9] ]]; then
	for-of "$@"
else
	for-of "$@" $(cat -)
fi
