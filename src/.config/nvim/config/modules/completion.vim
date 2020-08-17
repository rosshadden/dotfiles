""""""""""""""""
" SETTINGS
""""""""""""""""

set completeopt=noinsert,menuone,noselect

let g:coc_global_extensions = [
	\ 'coc-css',
	\ 'coc-emoji',
	\ 'coc-eslint',
	\ 'coc-go',
	\ 'coc-java',
	\ 'coc-json',
	\ 'coc-prettier',
	\ 'coc-pyls',
	\ 'coc-snippets',
	\ 'coc-tslint',
	\ 'coc-tslint-plugin',
	\ 'coc-tsserver',
	\ 'coc-yaml'
\ ]

if emoji#available()
	set completefunc=emoji#complete
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

	autocmd User asyncomplete_setup call asyncomplete#register_source({
		\ 'name': 'nim',
		\ 'whitelist': [ 'nim' ],
		\ 'completor': { opt, ctx -> nim#suggest#sug#GetAllCandidates({ start, candidates -> asyncomplete#complete(opt['name'], ctx, start, candidates) }) }
	\ })
augroup END

augroup completionColors
	autocmd!
	autocmd ColorScheme * highlight CocErrorSign ctermfg=Yellow guifg=#ffff00
augroup END

""""""""""""""""
" MAPPINGS
""""""""""""""""

" trigger completions
inoremap <silent><expr> <a-space> coc#refresh()

" accept snippet on <cr>
inoremap <silent><expr> <cr> (pumvisible()) ? coc#_select_confirm() : "\<c-g>u\<cr>\<c-r>=coc#on_enter()\<cr>"

" <tab>: completion.
inoremap <expr> <tab> (pumvisible()) ? "\<c-n>" : "\<tab>"
inoremap <expr> <s-tab> (pumvisible()) ? "\<c-p>" : "\<s-tab>"

if emoji#available()
	map gm :s/:\([^:]\+\):/\=emoji#for(submatch(1), submatch(0))/g<cr>
	map gM :%s/:\([^:]\+\):/\=emoji#for(submatch(1), submatch(0))/g<cr>
endif
