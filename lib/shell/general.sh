#!/usr/bin/env bash

# Colored man pages
man() {
	env \
		LESS_TERMCAP_mb=$'\E[01;31m' \
		LESS_TERMCAP_md=$'\E[01;38;5;74m' \
		LESS_TERMCAP_me=$'\E[0m' \
		LESS_TERMCAP_se=$'\E[0m' \
		LESS_TERMCAP_so=$'\E[38;5;246m' \
		LESS_TERMCAP_ue=$'\E[0m' \
		LESS_TERMCAP_us=$'\E[04;38;5;146m' \
	man "$@"
}

# make `history` have timestamps
export HIST_STAMPS=yyyy-mm-dd

goo=$?
if [[ $goo == 0 ]]; then
	if [[ -x /usr/bin/vimpager ]]; then
		export PAGER=vimpager
	fi
	alias less=$PAGER
	alias zless=$PAGER
fi

# alt-left and alt-up to navigate directories

cdUndoKey() {
	popd      > /dev/null
	zle       reset-prompt
	echo
	ls
	echo
}

cdParentKey() {
	pushd .. > /dev/null
	zle      reset-prompt
	echo
	ls
	echo
}

if [[ $(getShell) == 'zsh' ]]; then
	zle -N                 cdParentKey
	zle -N                 cdUndoKey
	bindkey '^[[1;3A'      cdParentKey
	bindkey '^[[1;3D'      cdUndoKey
fi
