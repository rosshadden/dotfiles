let g:dotsDir = '~/dotfiles'
let g:themesDir = '~/dotfiles/src/themes'

if has('nvim')
	let g:mainDir = '~/.config/nvim'
	let g:configFile = g:mainDir . '/init.vim'
else
	let g:mainDir = '~/.vim'
	let g:configFile = g:mainDir . '/vimrc'
endif

let g:configDir = g:mainDir . '/config'
let g:packageDir = g:mainDir . '/dein'
