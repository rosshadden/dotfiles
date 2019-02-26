" line numbers
set number

" timeouts
set timeoutlen=1000 ttimeoutlen=0

" title
set title

" highlight search results
set hlsearch

" casing
set smartcase ignorecase infercase

" spelling
set spell spelllang=en_us

" add visible stop column
set colorcolumn=120

" let buffers exist in the background
set hidden

" scrolling
set ruler
set scrolloff=3 sidescrolloff=5
set nostartofline

" disable splash screen and 'press ENTER' prompt
set shortmess=atIO

" add the g flag to search/replace by default
set gdefault

" disable showing current mode
set noshowmode

" better joins
set nojoinspaces

" simple mouse support
set mouse=a

" disable word wrap
set nowrap

" Let arrow keys pass \n
set whichwrap=b,s,<,>,[,]

" ignore in searches
set wildignore+=node_modules/**,.*.swp,.git/**

" prevent omnicomplete preview window
set completeopt-=preview

" only syntax highlight the beginning of lines
set synmaxcol=200

" allow alt-mappings in gvim
set guioptions-=m
set winaltkeys=no

" delay peekaboo menu
let g:peekaboo_delay = 1000
