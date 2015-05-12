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


blah=$(isCommand vimpager)
goo=$?
if [[ $goo == 0 ]]; then
	export PAGER=vimpager
	alias less=$PAGER
	alias zless=$PAGER
fi


autoload -U edit-command-line
zle -N edit-command-line
bindkey '\C-x\C-x' edit-command-line


# init fasd
eval "$(fasd --init auto)"
