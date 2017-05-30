""""""""""""""""
" SETTINGS
""""""""""""""""

" vim-pandoc-syntax
let g:pandoc#syntax#conceal#urls = 1
let g:pandoc#syntax#codeblocks#embeds#langs = [ 'javascript', 'js=javascript', 'json', 'bash=sh' ]

""""""""""""""""
" FUNCTIONS
""""""""""""""""

function! CompileMarkdown(files)
	let l:dir = expand('%:h:t')
	if l:dir == '.'
		let l:dir = expand('%:p:t')
	endif

	echo l:dir
	let l:output = '/tmp/' . l:dir . '.pdf'
	let l:options = ' -R -f markdown -o ' . l:output . ' -V geometry:margin=1in -V fontsize=12pt '

	let l:cmd = 'pandoc' . l:options . a:files

	write
	execute '!' . l:cmd
endfunction

""""""""""""""""
" MAPPINGS
""""""""""""""""

augroup markdown
	autocmd!

	" treat other files as markdown
	autocmd BufEnter,BufNew *.txt set ft=pandoc

	" spell check
	autocmd FileType markdown setlocal spell | setlocal complete+=kspell

	" compile to pdf
	autocmd FileType markdown
		\ noremap <localleader>c :call CompileMarkdown(expand('%:p'))<cr> |
		\ noremap <localleader>C :call CompileMarkdown('*.md')<cr>

	" live preview
	autocmd FileType markdown noremap <localleader>p :ComposerOpen<cr>
augroup END
