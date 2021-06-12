let g:dotsDir = '~/dotfiles'
let g:themesDir = '~/dotfiles/lib/themes'

if has('nvim')
	let g:vimDir = '~/.config/nvim'
	let g:configFile = g:vimDir . '/init.vim'
else
	let g:vimDir = '~/.vim'
	let g:configFile = g:vimDir . '/vimrc'
endif

let g:configDir = g:vimDir . '/config'
let g:packageDir = g:vimDir . '/plugged'

" https://github.com/junegunn/vim-plug/wiki/faq
function! LoadIf(cond, ...)
	let opts = get(a:000, 0, {})
	return (a:cond) ? opts : extend(opts, { 'on': [], 'for': [] })
endfunction
