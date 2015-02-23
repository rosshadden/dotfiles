" enable
let g:neocomplete#enable_at_startup = 1

" smartcase
let g:neocomplete#enable_smart_case = 1

" max candidates
let g:neocomplete#max_list = 32

" disable fuzzy completion
let g:neocomplete#enable_fuzzy_completion = 0

" <TAB>: completion.
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
inoremap <expr><s-tab> pumvisible() ? "\<c-p>" : "\<s-tab>"

" fix backspace
inoremap <expr><c-h> neocomplete#smart_close_popup() . "\<c-h>"
inoremap <expr><bs> neocomplete#smart_close_popup() . "\<c-h>"

" Enable omni completion.
augroup omnicomplete
	autocmd!
	autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
	autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
	autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
	autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
	autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
augroup END
