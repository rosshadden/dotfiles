if dein#tap('neomake')
	augroup syntax
		autocmd!
		autocmd BufWritePost * Neomake
	augroup END
endif
