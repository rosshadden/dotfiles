" line numbers
set number
set hlsearch
set cursorline
" set relativenumber

set spell

set colorcolumn=80,120

" timeout
" set timeout timeoutlen=500 ttimeoutlen=50
set timeout timeoutlen=1000 ttimeoutlen=-1

" tabs! (not to be confused with tabs)
set tabstop=4
set shiftwidth=4

" turn off auto-textwrap (vim-sensible turns it on)
set textwidth=0

" simple mouse support
set mouse=a

" Let arrow keys pass \n
set whichwrap=b,s,<,>,[,]

" ignore in searches
set wildignore+=node_modules/**
