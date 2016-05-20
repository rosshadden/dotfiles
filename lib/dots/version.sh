#!/usr/bin/env bash

source "$(dirname $0)/functions.sh"

action="$1"
shift

versionFile="$DOTS/VERSION"
version="$(cat "$versionFile")"

case "$action" in
	b | bump)
		major="$(echo $version | cut -d. -f1)"
		minor="$(echo $version | cut -d. -f2)"
		patch="$(echo $version | cut -d. -f3)"
		doTag=false

		spec=":t"
		while getopts $spec opt; do
			case "$opt" in
				t) doTag=true ;;
			esac
		done
		shift "$((OPTIND-1))"

		type="${1:-patch}"

		case "$type" in
			M | major) ((major++)) ;;
			m | minor) ((minor++)) ;;
			p | patch) ((patch++)) ;;
		esac

		newVersion="$major.$minor.$patch"

		echo "Incrementing version: $version => $newVersion"
		echo "$newVersion" > $versionFile
		if $doTag; then $0 tag; fi
		;;
	t | tag)
		echo "Tagging version: v$version"
		pushd $DOTS &> /dev/null
			git tag "v$version"
		popd &> /dev/null
		;;
	*) echo $version ;;
esac
