function! CompileMarkdown(files)
	let l:dir = expand("%:h:t")
	if l:dir == "."
		let l:dir = expand("%:p:t")
	endif

	echo l:dir
	let l:output = "/tmp/" . l:dir . ".pdf"
	let l:options = " -R -f markdown -o " . l:output . " -V geometry:margin=1in -V fontsize=12pt "

	let l:cmd = "pandoc" . l:options . a:files

	write
	execute "!" . l:cmd
endfunction


augroup markdown
	" syntax highlighting
	" autocmd BufNewFile,BufRead *.md set filetype=markdown

	" spell check
	autocmd FileType markdown setlocal spell | setlocal complete+=kspell

	" compile to pdf
	autocmd FileType markdown
		\ noremap <localleader>c :call CompileMarkdown(expand("%:p"))<cr> |
		\ noremap <localleader>C :call CompileMarkdown("*.md")<cr>
augroup END


""""""""""""""""
" PLUGINS
""""""""""""""""

" vim-instant-markdown

" disable autostart
let g:instant_markdown_autostart = 0

noremap <localleader>p :InstantMarkdownPreview<cr>
