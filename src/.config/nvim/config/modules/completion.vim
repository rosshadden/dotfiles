""""""""""""""""
" SETTINGS
""""""""""""""""

" enable
let g:deoplete#enable_at_startup = 1
let g:neocomplete#enable_at_startup = 1

" smartcase
let g:neocomplete#enable_smart_case = 1

" max candidates
let g:neocomplete#max_list = 32

" start after a certain number of characters
let g:neocomplete#auto_completion_start_length = 3
let g:neocomplete#sources#syntax#min_keyword_length = 2

" disable fuzzy completion
let g:neocomplete#enable_fuzzy_completion = 0

" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
	let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
	let g:neocomplete#sources#omni#input_patterns = {}
endif
let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'
let g:neocomplete#sources#omni#input_patterns.cs = '.*[^=\);]'
let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'
let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'

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

inoremap <expr><c-y> neocomplete#undo_completion()
" TODO: doesn't seem to work
inoremap <expr><c-e> neocomplete#complete_common_string()

" <TAB>: completion.
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
inoremap <expr><s-tab> pumvisible() ? "\<c-p>" : "\<s-tab>"

" <cr>: close popup and save indent.
inoremap <silent> <cr> <c-r>=<sid>my_cr_function()<cr>
function! s:my_cr_function()
	return neocomplete#close_popup() . "\<cr>"
	" For no inserting <cr> key.
	"return pumvisible() ? neocomplete#close_popup() : "\<cr>"
endfunction

" fix backspace
" inoremap <expr><c-h> neocomplete#smart_close_popup() . "\<c-h>"
inoremap <expr><bs> neocomplete#smart_close_popup() . "\<c-h>"
