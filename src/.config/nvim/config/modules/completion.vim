""""""""""""""""
" SETTINGS
""""""""""""""""

" enable
let g:deoplete#enable_at_startup = 1

" smartcase
let g:deoplete#enable_smart_case = 1

let g:deoplete#enable_refresh_always = 1

" max candidates
let g:deoplete#max_list = 32

" start after a certain number of characters
" let g:deoplete#auto_complete_start_length = 2

" Define keyword.
if !exists('g:deoplete#keyword_patterns') | let g:deoplete#keyword_patterns = {} | endif
let g:deoplete#keyword_patterns['default'] = '\h\w*'

" Enable heavy omni completion.
if !exists('g:deoplete#omni#input_patterns') | let g:deoplete#omni#input_patterns = {} | endif
let g:deoplete#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
let g:deoplete#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'
let g:deoplete#omni#input_patterns.cs = '.*[^=\);]'
let g:deoplete#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'
let g:deoplete#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
let g:deoplete#omni#input_patterns.nim = '[^. *\t]\.\w*'

if !exists('g:deoplete#omni#functions') | let g:deoplete#omni#functions = {} | endif
let g:deoplete#omni#functions.nim = 'omni#nim'

let g:deoplete#sources = {}
let g:deoplete#sources._ = [ 'buffer' ]
let g:deoplete#sources.cpp = [ 'deoplete-clang2', 'buffer', 'tag' ]

" if emoji#available()
" 	set completefunc=emoji#complete
" endif

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

inoremap <expr><c-y> deoplete#mappings#undo_completion()

" fix backspace
inoremap <expr><bs> deoplete#mappings#smart_close_popup() . "\<c-h>"

" <tab>: completion.
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
inoremap <expr><s-tab> pumvisible() ? "\<c-p>" : "\<s-tab>"

function! s:my_cr_function()
	" return ((pumvisible()) ? "\<c-y>" : "" ) . "\<cr>"
	" For not inserting `<cr>`
	return (pumvisible()) ? "\<c-y>" : "\<cr>"
endfunction

" <cr>: close popup and save indent.
inoremap <silent> <cr> <c-r>=<sid>my_cr_function()<cr>

if emoji#available()
	map gm :s/:\([^:]\+\):/\=emoji#for(submatch(1), submatch(0))/g<cr>
	map gM :%s/:\([^:]\+\):/\=emoji#for(submatch(1), submatch(0))/g<cr>
endif
