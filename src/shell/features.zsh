# bracket object
autoload -U select-bracketed
zle -N select-bracketed
for m in visual viopp; do
	for c in {a,i}${(s..)^:-'()[]{}<>bB'}; do
		bindkey -M $m $c select-bracketed
	done
done

# quote object
autoload -U select-quoted
zle -N select-quoted
for m in visual viopp; do
	for c in {a,i}{\',\",\`}; do
		bindkey -M $m $c select-quoted
	done
done

# surround
# https://github.com/zsh-users/zsh/blob/master/Functions/Zle/surround
autoload -Uz surround
zle -N delete-surround surround
zle -N add-surround surround
zle -N change-surround surround
bindkey -a cs change-surround
bindkey -a ds delete-surround
bindkey -a ys add-surround
bindkey -M visual S add-surround

# enhanced <m-.> and <m-m> argument completion
# http://chneukirchen.org/blog/archive/2013/03/10-fresh-zsh-tricks-you-may-not-know.html
autoload -Uz copy-earlier-word
zle -N copy-earlier-word
bindkey "^[m" copy-earlier-word

# edit command externally
autoload -Uz edit-command-line
zle -N edit-command-line
# INSERT
bindkey '\C-x\C-x' edit-command-line
# NORMAL
bindkey -a '\C-x\C-x' edit-command-line

# # zsh-syntax-highlighting
# source $shellDir/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)
# ZSH_HIGHLIGHT_STYLES[path]='fg=cyan'
# ZSH_HIGHLIGHT_STYLES[commandseparator]='fg=red'


# zsh-autosuggestions
source $shellDir/plugins/zsh-autosuggestions/autosuggestions.zsh
