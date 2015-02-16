#!/usr/bin/env bash

calc() {
	echo "$1" | bc
}


function countdown() {
	date1=$((`date +%s` + $1));
	while [ "$date1" -ne `date +%s` ]; do
		echo -ne "$(date -u --date @$((`date +%s` - $date1)) +%H:%M:%S)\r";
	done
}


function stopwatch() {
	date1=`date +%s`;
	while true; do
		echo -ne "\r$(date -u --date @$((`date +%s` - $date1)) +%H:%M:%S)";
	done
}


panewrap () {
	printf "\033]2;%s\033\\" "$1"; "$@";
}
