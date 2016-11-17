zle -N cdParentKey
zle -N cdUndoKey
bindkey '^[[1;3A' cdParentKey
bindkey '^[[1;3D' cdUndoKey

# clear line
bindkey '^Q' push-line

# fix shift-tab in completion menus
bindkey -a '	' menu-expand-or-complete

# fix shift-tab in completion menus
bindkey '^[[Z' reverse-menu-complete

# copy yank register to X clipboard
vi-yank-to-x() { print -rn -- $CUTBUFFER | xsel -ib -p; }
zle -N vi-yank-to-x
bindkey -a '^Y' vi-yank-to-x
