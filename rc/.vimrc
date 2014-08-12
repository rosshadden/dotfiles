filetype plugin on
syntax on

set number
set smartcase
set incsearch
set hlsearch
set mouse=a
set pastetoggle=<F5>

" Let arrow keys pass \n
set whichwrap=b,s,<,>,[,]

" Preserve cursor position
if has("autocmd")
	au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
endif

" Get sudo when it has been forgotten.
cmap w!! w !sudo tee > /dev/null %

" ctrl+s to save
noremap		<silent> <C-S>		:update<CR>
vnoremap	<silent> <C-S>		<C-C>:update<CR>
inoremap	<silent> <C-S>		<C-O>:update<CR>

" ctrl+q to (force) quit
noremap		<silent> <C-Q>		:quit!<CR>
vnoremap	<silent> <C-Q>		<C-C>:quit!<CR>
inoremap	<silent> <C-Q>		<C-O>:quit!<CR>

" ctrl+x to save and quit
noremap		<silent> <C-X>		:wq<CR>
vnoremap	<silent> <C-X>		<C-C>:wq<CR>
inoremap	<silent> <C-X>		<C-O>:wq<CR>

" U to redo
noremap		U			<C-r>

" When vimrc is edited, reload it
autocmd! bufwritepost vimrc source ~/.vimrc

