" line numbers
set number

" highlight search results
set hlsearch

" casing
set smartcase ignorecase

" spelling
set spell spelllang=en_us

" add visible stop column
set colorcolumn=120

" timeout
set timeout timeoutlen=1000

" turn off auto-textwrap (vim-sensible turns it on)
set textwidth=0 wrapmargin=0

" let buffers exist in the background
set hidden

" disable splash screen
set shortmess=atI

" add the g flag to search/replace by default
set gdefault

" simple mouse support
set mouse=a

" Let arrow keys pass \n
set whichwrap=b,s,<,>,[,]

" ignore in searches
set wildignore+=node_modules/**,.*.swp,.git/**

" prevent omnicomplete preview window
set completeopt-=preview

" allow alt-mappings in gvim
set guioptions-=m
set winaltkeys=no
