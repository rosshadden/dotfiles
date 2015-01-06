" try to be smart about completion context
let g:SuperTabDefaultCompletionType = 'context'


" use omnifunc completion when possible
autocmd FileType *
	\ if &omnifunc != '' |
		\ call SuperTabChain(&omnifunc, '<c-p>') |
	\ endif
