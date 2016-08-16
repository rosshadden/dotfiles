" line numbers
set number
set relativenumber

" timeouts
set timeoutlen=1000 ttimeoutlen=0

" title
set title

" highlight search results
set hlsearch

" casing
set smartcase ignorecase

" spelling
set spell spelllang=en_us

" add visible stop column
set colorcolumn=120

" let buffers exist in the background
set hidden

" scrolling
set ruler
set scrolloff=1 sidescrolloff=5

" disable splash screen
set shortmess=atI

" add the g flag to search/replace by default
set gdefault

" simple mouse support
if !has('nvim') | set mouse=a | endif

" Let arrow keys pass \n
set whichwrap=b,s,<,>,[,]

" ignore in searches
set wildignore+=node_modules/**,.*.swp,.git/**

" prevent omnicomplete preview window
set completeopt-=preview

" allow alt-mappings in gvim
set guioptions-=m
set winaltkeys=no
