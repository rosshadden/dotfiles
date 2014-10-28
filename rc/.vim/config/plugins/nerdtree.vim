" show hidden files
let g:NERDTreeShowHidden = 1

" always focus file pane (this doesn't seem to work)
" let g:nerdtree_tabs_smart_startup_focus = 2

" if no files were passed, open NERDTree on startup
" autocmd StdinReadPre * let s:std_in=1
" autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" L-n => toggle NERDTreeTabs
map <leader>t <plug>NERDTreeTabsToggle<cr>
