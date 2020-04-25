################
# DEFINITIONS
################

counter=0
for color in BLACK RED GREEN YELLOW BLUE MAGENTA CYAN WHITE; do
	eval $color='$(tput setaf $counter)'
	let counter=counter+1
done
RESET=$(tput sgr0)
unset counter

################
# INIT
################

shell="$(getShell)"
if [[ "$shell" == "zsh" ]]; then
	if isCommand dircolors; then
		eval "$(dircolors -b $ZPLUG_REPOS/trapd00r/LS_COLORS/LS_COLORS)"
	elif isCommand gdircolors; then
		eval "$(gdircolors -b $ZPLUG_REPOS/trapd00r/LS_COLORS/LS_COLORS)"
	fi
fi
