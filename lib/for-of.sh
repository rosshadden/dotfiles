#!/usr/bin/env zsh

# TODO: add option for suppressing header
for-of() {
	local cmd=$1
	local section='\\n################\\n# $name\\n################'
	cmd="if [[ -d \$name ]]; then echo $section; cd \$name; $cmd; cd ../; fi"

	for-in $cmd
}

for-of "$@"
