#!/usr/bin/env bash

source "$(dirname $0)/functions.sh"

while getopts "" opt; do
	case "$opt" in
		*) error "Invalid option: '-$OPTARG'" ;;
	esac
done
shift "$((OPTIND-1))"

echo "TODO"
