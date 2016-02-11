#!/usr/bin/env bash

##
# Opens file from Unity in gvim.
# The gvim instance is reused, and additional files are opened as tabs within it.
# Supports opening files to a specific line if passed.
#
# @param {Path} file - The path of the file to open
# @param {Number} [line] - The line number to open
##

IFS=':' read -a params <<< "$1"

file=${params[0]}
line=${params[1]}

if [[ $line != 0 ]]; then
	file="+$line $file"
fi

server="UNITY"
app="vim"

vim --serverlist | grep $server || app="gvim"

$app --servername $server --remote-tab $file
