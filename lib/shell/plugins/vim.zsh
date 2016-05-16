# Shamelessly modified from https://github.com/sharat87/zsh-vim-mode
# Huge thanks to @sharat87 !

# Original from oh-my-zsh plugins.

KEYTIMEOUT=1


function zle-line-init zle-keymap-select {
	zle reset-prompt
}

# zle -N zle-line-init
zle -N zle-keymap-select

bindkey -v

bindkey -M vicmd ' ' execute-named-cmd # Space for command line mode

# TODO: make everything work in tmux

# DEL
bindkey -M main -M vicmd -M viins '\e[3^' delete-word
bindkey -M main -M vicmd -M viins '\e[33~' backward-kill-word
# HOME
bindkey '\e[1~' vi-beginning-of-line
bindkey '\eOH' vi-beginning-of-line
# END
bindkey '\e[4~' vi-end-of-line
bindkey '\eOF' vi-end-of-line

bindkey -M viins '^o' vi-backward-kill-word

bindkey -M vicmd 'Y' vi-yank-eol

# redo
bindkey -M vicmd 'U' redo

# `man` page of base command
bindkey -M viins '\eh' run-help

bindkey '^p' history-substring-search-up
bindkey '^n' history-substring-search-down
bindkey -M vicmd '^p' history-substring-search-up
bindkey -M vicmd '^n' history-substring-search-down

bindkey -M vicmd '\-' vi-repeat-find
bindkey -M vicmd '_' vi-rev-repeat-find

bindkey -M vicmd -M viins '\e.' insert-last-word

bindkey -M viins '^a' beginning-of-line
bindkey -M viins '^e' end-of-line

# <space> to expand history expansion
bindkey ' ' magic-space

# history substring searching
bindkey -M vicmd -M viins 'R' history-incremental-pattern-search-backward

# enhanced <c-r>
# http://chneukirchen.org/blog/archive/2013/03/10-fresh-zsh-tricks-you-may-not-know.html
autoload -Uz narrow-to-region
function _history-incremental-preserving-pattern-search-backward {
	local state
	MARK=CURSOR  # magick, else multiple ^R don't work
	narrow-to-region -p "$LBUFFER${BUFFER:+>>}" -P "${BUFFER:+<<}$RBUFFER" -S state
	zle end-of-history
	zle history-incremental-pattern-search-backward
	narrow-to-region -R state
}
zle -N _history-incremental-preserving-pattern-search-backward
bindkey "^R" _history-incremental-preserving-pattern-search-backward
bindkey -M isearch "^R" history-incremental-pattern-search-backward
bindkey "^S" history-incremental-pattern-search-forward

# expand .[TAB] and ..[TAB]
zstyle -e ':completion:*' special-dirs '[[ $PREFIX = (../)#(|.|..) ]] && reply=(..)'
