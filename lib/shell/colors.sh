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

eval $(dircolors ~/.dircolors)
