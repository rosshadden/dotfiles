" line numbers
set number
set hlsearch
set cursorline

" smart case
set smartcase
set ignorecase

set spell
set spelllang=en_us

set colorcolumn=80,120

" timeout
" set timeout timeoutlen=500 ttimeoutlen=50
set timeout timeoutlen=1000 ttimeoutlen=-1

" tabs! (not to be confused with tabs)
set tabstop=4
set shiftwidth=4

" turn off auto-textwrap (vim-sensible turns it on)
set textwidth=0

" disable splash screen
set shortmess=atI

" add the g flag to search/replace by default
set gdefault

" simple mouse support
set mouse=a

" Let arrow keys pass \n
set whichwrap=b,s,<,>,[,]

" ignore in searches
set wildignore+=node_modules/**
