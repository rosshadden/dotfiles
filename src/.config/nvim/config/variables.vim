let g:dotsDir = '~/dotfiles'
let g:themesDir = '~/dotfiles/src/themes'

if has('nvim')
	let g:vimDir = '~/.config/nvim'
	let g:configFile = g:vimDir . '/init.vim'
else
	let g:vimDir = '~/.vim'
	let g:configFile = g:vimDir . '/vimrc'
endif

let g:configDir = g:vimDir . '/config'
let g:packageDir = g:vimDir . '/plugged'
