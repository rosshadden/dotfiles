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
# THEME
################

typeset -A colors

colors[normal]="#5F00AF"
colors[normal2]="#875FD7"

colors[insert]="#0087FF"
colors[insert2]="#00AFFF"

colors[visual]="#FF5F00"
colors[visual2]="#FFAF00"

colors[replace]="#FF0000"
colors[replace2]="#FF5F5F"

colors[background]="#151515"
colors[foreground]="#FFFFFF"

################
# INIT
################

eval $(dircolors ~/.dircolors)
