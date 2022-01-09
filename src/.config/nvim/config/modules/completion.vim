""""""""""""""""
" SETTINGS
""""""""""""""""

set completeopt=noinsert,menuone,noselect

let g:coc_global_extensions = [
	\ 'coc-browser',
	\ 'coc-css',
	\ 'coc-emoji',
	\ 'coc-eslint',
	\ 'coc-go',
	\ 'coc-java',
	\ 'coc-json',
	\ 'coc-omnisharp',
	\ 'coc-prettier',
	\ 'coc-pyls',
	\ 'coc-snippets',
	\ 'coc-tsserver',
	\ 'coc-yaml'
\ ]

lua << EOF
local lsp = require('lspconfig')

local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

	buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')
end

local servers = { "nimls", "tsserver" }
for _, server in ipairs(servers) do
	lsp[server].setup { on_attach = on_attach }
end
EOF

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
augroup END

augroup completionColors
	autocmd!
	autocmd ColorScheme * highlight CocErrorSign ctermfg=Yellow guifg=#ffff00
augroup END

""""""""""""""""
" MAPPINGS
""""""""""""""""

" restart coc
nnoremap <:app>o :CocRestart<cr>

" trigger completions
inoremap <silent><expr> <a-space> coc#refresh()

" accept snippet on <cr>
inoremap <silent><expr> <cr> (pumvisible()) ? coc#_select_confirm() : "\<c-g>u\<cr>\<c-r>=coc#on_enter()\<cr>"

" <tab>: completion.
inoremap <expr> <tab> (pumvisible()) ? "\<c-n>" : "\<tab>"
inoremap <expr> <s-tab> (pumvisible()) ? "\<c-p>" : "\<s-tab>"

try
	nmap <silent> [c :call CocAction('diagnosticPrevious')<cr>
	nmap <silent> ]c :call CocAction('diagnosticNext')<cr>
endtry

if emoji#available()
	map gm :s/:\([^:]\+\):/\=emoji#for(submatch(1), submatch(0))/g<cr>
	map gM :%s/:\([^:]\+\):/\=emoji#for(submatch(1), submatch(0))/g<cr>
endif
