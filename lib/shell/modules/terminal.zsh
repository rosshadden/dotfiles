# Make special keys work

# create a zkbd compatible hash;
# to add other keys to this hash, see: man 5 terminfo
typeset -A key

key[Home]=${terminfo[khome]}
key[End]=${terminfo[kend]}
key[Insert]=${terminfo[kich1]}
key[Delete]=${terminfo[kdch1]}
key[Up]=${terminfo[kcuu1]}
key[Down]=${terminfo[kcud1]}
key[Left]=${terminfo[kcub1]}
key[Right]=${terminfo[kcuf1]}
key[PageUp]=${terminfo[kpp]}
key[PageDown]=${terminfo[knp]}

# setup key accordingly
if [[ -n "${key[End]}"      ]]; then bindkey  "${key[End]}"      end-of-line; fi
if [[ -n "${key[Insert]}"   ]]; then bindkey  "${key[Insert]}"   overwrite-mode; fi
if [[ -n "${key[Delete]}"   ]]; then bindkey  "${key[Delete]}"   delete-char; fi
if [[ -n "${key[Up]}"       ]]; then bindkey  "${key[Up]}"       up-line-or-history; fi
if [[ -n "${key[Down]}"     ]]; then bindkey  "${key[Down]}"     down-line-or-history; fi
if [[ -n "${key[Left]}"     ]]; then bindkey  "${key[Left]}"     backward-char; fi
if [[ -n "${key[Right]}"    ]]; then bindkey  "${key[Right]}"    forward-char; fi
if [[ -n "${key[PageUp]}"   ]]; then bindkey  "${key[PageUp]}"   beginning-of-buffer-or-history; fi
if [[ -n "${key[PageDown]}" ]]; then bindkey  "${key[PageDown]}" end-of-buffer-or-history; fi

# Finally, make sure the terminal is in application mode, when zle is active.
# Only then are the values from $terminfo valid.
if (( ${+terminfo[smkx]} )) && (( ${+terminfo[rmkx]} )); then
	function zle-line-init () { printf '%s' "${terminfo[smkx]}" }
	function zle-line-finish () { printf '%s' "${terminfo[rmkx]}" }
	zle -N zle-line-init
	zle -N zle-line-finish
fi
