#!/usr/bin/env bash

################
# FUNCTIONS
################

##
# Automatically change the directory after closing ranger
##
ranger-cd() {
	tempfile="$(mktemp -t tmp.XXXXXX)"
	/usr/bin/ranger --choosedir="$tempfile" "${@:-$(pwd)}"
	test -f "$tempfile" &&
	if [ "$(cat -- "$tempfile")" != "$(echo -n $(pwd))" ]; then
		cd -- "$(cat "$tempfile")" || exit
	fi
	rm -f -- "$tempfile"
}

################
# MAPPINGS
################

# run ranger-cd
shell="$(getShell)"
if [[ "$shell" == "zsh" ]]; then
	bindkey -s '^O' '^qranger-cd\n'
elif [[ "$shell" == "bash" ]]; then
	bind '"\C-o":"ranger-cd\C-m"'
fi

# load `fzf` mappings
shell="$(getShell)"
if [[ -f /usr/share/fzf/key-bindings.$shell ]]; then fzfMappings=/usr/share/fzf/key-bindings.$shell; fi
if [[ -f /etc/profile.d/fzf.$shell ]]; then fzfMappings=/etc/profile.d/fzf.$shell; fi
if [[ "$fzfMappings" != "" ]]; then source $fzfMappings; fi
