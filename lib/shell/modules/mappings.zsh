zle -N cdParentKey
zle -N cdUndoKey
bindkey '^[[1;3A' cdParentKey
bindkey '^[[1;3D' cdUndoKey

# fix shift-tab in completion menus
bindkey -a '	' menu-expand-or-complete

# fix shift-tab in completion menus
bindkey '^[[Z' reverse-menu-complete

# copy yank register to X clipboard
vi-yank-to-x() { print -rn -- $CUTBUFFER | xsel -ib -p; }
zle -N vi-yank-to-x
bindkey -a '^Y' vi-yank-to-x

# load `fzf` mappings
local shell="$(getShell)"
if [[ -f /usr/share/fzf/key-bindings.$shell ]]; then local fzfMappings=/usr/share/fzf/key-bindings.$shell; fi
if [[ -f /etc/profile.d/fzf.$shell ]]; then local fzfMappings=/etc/profile.d/fzf.$shell; fi
if [[ "$fzfMappings" != "" ]]; then source $fzfMappings; fi
