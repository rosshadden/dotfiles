#!/usr/bin/env bash

source "$DOTS/lib/shell/init/functions.sh"

while getopts "" opt; do
	case "$opt" in
		*) error "Invalid option: '-$OPTARG'" ;;
	esac
done
shift "$((OPTIND-1))"

echo "TODO"
