local themeDir=$DOTS/lib/themes

eval "$(starship init zsh)"

# base16 colors
if [ "${TERM%%-*}" = 'linux' ]; then
	BASE16_TYPE="vconsole"
else
	BASE16_TYPE="shell"
fi

BASE16_SHELL="$themeDir/$BASE16_TYPE"

[[ -f "$BASE16_SHELL" ]] && source $BASE16_SHELL
