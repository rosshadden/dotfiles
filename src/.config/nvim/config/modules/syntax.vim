if IsLoaded('neomake')
	augroup syntax
		autocmd!
		autocmd BufWritePost * Neomake
	augroup END
endif
