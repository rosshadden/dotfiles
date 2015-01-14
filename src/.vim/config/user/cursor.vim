" TODO: cleanup the tmux-vs-not differences


let s:prefixCode = ""
let s:suffixCode = ""

if exists('$TMUX')
	let s:tmuxPrefix = "\<Esc>Ptmux;\<Esc>"
	let s:tmuxSuffix = "\<Esc>\\"

	let s:prefixCode .= "\033Ptmux;\033"
	let s:suffixCode .= "\033\\"
endif


" PREFIX

let &t_SI = ""
let &t_EI = ""

if exists('$TMUX')
	let &t_SI .= s:tmuxPrefix
	let &t_EI .= s:tmuxPrefix
endif


" COLOR

" insert
let &t_SI .= "\<Esc>]12;cyan\x7"

" normal
let &t_EI .= "\<Esc>]12;gray\x7"
execute 'silent !echo -ne "' . s:prefixCode . '\033]12;gray\007' . s:suffixCode . '"'

" reset
autocmd FocusGained * execute 'silent !echo -ne "' . s:prefixCode . '\033]12;gray\007' . s:suffixCode . '"'
autocmd VimLeave * execute 'silent !echo -ne "' . s:prefixCode . '\033]12;gray\007' . s:suffixCode . '"'


" SHAPE

" KEY:
	" 1 or 0 -> blinking block
	" 2 -> solid block
	" 3 -> blinking underscore
	" 4 -> solid underscore
	" Recent versions of xterm (282 or above) also support
	" 5 -> blinking vertical bar
	" 6 -> solid vertical bar

" insert (underscore)
let &t_SI .= "\<Esc>\<Esc>[5 q"

" normal (block)
let &t_EI .= "\<Esc>\<Esc>[2 q"

" reset
autocmd FocusGained * execute 'silent !echo -ne "' . s:prefixCode . '\033[2 q' . s:suffixCode . '"'
autocmd VimLeave * execute 'silent !echo -ne "' . s:prefixCode . '\033[2 q' . s:suffixCode . '"'


" SUFFIX

if exists('$TMUX')
	let &t_SI .= s:tmuxSuffix
	let &t_EI .= s:tmuxSuffix
endif
