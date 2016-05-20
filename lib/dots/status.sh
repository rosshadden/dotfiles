#!/usr/bin/env bash

source "$(dirname $0)/functions.sh"

# TODO: report whether submodules have remote changes
# TODO: report whether `tmux` plugins are updated
# TODO: report whether `vim` plugins are updated
# TODO: report whether `pass` is synced
# TODO: report whether `task` is synced

pushd $DOTS &> /dev/null

while getopts ":f" opt; do
	case "$opt" in
		f) git fetch ;;
		*) error "Invalid option: -$OPTARG" ;;
	esac
done
shift "$((OPTIND-1))"

git status -sb

popd &> /dev/null
