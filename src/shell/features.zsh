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
bindkey -a s add-surround
bindkey -M visual s add-surround

# enhanced <m-.> and <m-m> argument completion
# http://chneukirchen.org/blog/archive/2013/03/10-fresh-zsh-tricks-you-may-not-know.html
autoload -Uz copy-earlier-word
zle -N copy-earlier-word
bindkey "^[m" copy-earlier-word

# smart-insert-last-word
# TODO: requires zsh 5.1
# zle -N insert-last-word smart-insert-last-word

# edit command externally
autoload -Uz edit-command-line
zle -N edit-command-line
# INSERT
bindkey '\C-x\C-x' edit-command-line
# NORMAL
bindkey -a '\C-x\C-x' edit-command-line

# predict-on
autoload -Uz predict-on
zle -N predict-on
zle -N predict-off
bindkey '^[t' predict-on
bindkey '^[T' predict-off

# url-quote-magic
autoload -Uz url-quote-magic
zle -N self-insert url-quote-magic
autoload -Uz bracketed-paste-magic
zle -N bracketed-paste bracketed-paste-magic


################
# PLUGINS
################

# zsh-syntax-highlighting
source $shellDir/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# TODO: pending https://github.com/zsh-users/zsh-syntax-highlighting/issues/165
# ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)
ZSH_HIGHLIGHT_HIGHLIGHTERS=(brackets)
ZSH_HIGHLIGHT_STYLES[commandseparator]='fg=red'
