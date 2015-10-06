""""""""""""""""
" SETTINGS
""""""""""""""""

" enable
let g:neocomplete#enable_at_startup = 1

" smartcase
let g:neocomplete#enable_smart_case = 1

" max candidates
let g:neocomplete#max_list = 32

" start after 3 characters
let g:neocomplete#auto_completion_start_length = 3

" disable fuzzy completion
let g:neocomplete#enable_fuzzy_completion = 0

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
	let g:neocomplete#sources#omni#input_patterns = {}
endif

" Enable omni completion.
augroup completion
	autocmd!
	autocmd FileType cs setlocal omnifunc=OmniSharp#Complete
	autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
	autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
	autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
	autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
	autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
augroup END


""""""""""""""""
" MAPPINGS
""""""""""""""""

" <TAB>: completion.
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
inoremap <expr><s-tab> pumvisible() ? "\<c-p>" : "\<s-tab>"

" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
	return neocomplete#close_popup() . "\<CR>"
	" For no inserting <CR> key.
	"return pumvisible() ? neocomplete#close_popup() : "\<CR>"
endfunction

" fix backspace
inoremap <expr><c-h> neocomplete#smart_close_popup() . "\<c-h>"
inoremap <expr><bs> neocomplete#smart_close_popup() . "\<c-h>"
