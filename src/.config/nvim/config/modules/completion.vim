""""""""""""""""
" SETTINGS
""""""""""""""""

set completeopt=noinsert,menuone,noselect

if emoji#available()
	set completefunc=emoji#complete
endif

" Enable omni completion.
augroup completion
	autocmd!
	autocmd BufEnter * call ncm2#enable_for_buffer()
	autocmd FileType cs setlocal omnifunc=OmniSharp#Complete
	autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
	autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
	autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
	autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
	autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

	au User asyncomplete_setup call asyncomplete#register_source({
		\ 'name': 'nim',
		\ 'whitelist': [ 'nim' ],
		\ 'completor': { opt, ctx -> nim#suggest#sug#GetAllCandidates({ start, candidates -> asyncomplete#complete(opt['name'], ctx, start, candidates) }) }
	\ })
augroup END

""""""""""""""""
" MAPPINGS
""""""""""""""""

" CTRL-C doesn't trigger the InsertLeave autocmd . map to <ESC> instead.
inoremap <c-c> <esc>

" When the <Enter> key is pressed while the popup menu is visible, it only hides the menu.
" Use this mapping to close the menu and also start a new line.
inoremap <expr> <cr> (pumvisible() ? "\<c-y>\<cr>" : "\<cr>")

" <tab>: completion.
inoremap <expr> <tab> pumvisible() ? "\<c-n>" : "\<tab>"
inoremap <expr> <s-tab> pumvisible() ? "\<c-p>" : "\<s-tab>"

if emoji#available()
	map gm :s/:\([^:]\+\):/\=emoji#for(submatch(1), submatch(0))/g<cr>
	map gM :%s/:\([^:]\+\):/\=emoji#for(submatch(1), submatch(0))/g<cr>
endif
