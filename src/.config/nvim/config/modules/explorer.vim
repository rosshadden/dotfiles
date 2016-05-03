""""""""""""""""
" FUNCTIONS
""""""""""""""""

if !exists('g:rangerPath') | let g:rangerPath = 'ranger' | endif

if has('nvim')
	function! OpenRanger(dir)
		let currentPath = expand(a:dir)
		let tempFilePath = tempname()
		let rangerCallback = { 'name': 'ranger' , 'tempFilePath': tempFilePath }

		function! rangerCallback.on_exit(id, code)
			bdelete!

			if filereadable(self.tempFilePath)
				for file in readfile(self.tempFilePath)
					exec 'edit '. file
				endfor

				call delete(self.tempFilePath)
			endif
		endfunction

		tabnew

		call termopen(g:rangerPath . ' --choosefiles=' . shellescape(tempFilePath) . ' ' . currentPath, rangerCallback)

		startinsert
	endfunction
else
	function! OpenRanger(dir)
		let currentPath = expand(a:dir)
		let tempFilePath = tempname()

		exec 'silent !' . g:rangerPath . ' --choosefiles=' . shellescape(tempFilePath) . ' ' .currentPath

		if filereadable(tempFilePath)
			for file in readfile(tempFilePath)
				exec 'edit '. file
			endfor

			call delete(tempFilePath)
		endif

		redraw!
	endfunction
endif

""""""""""""""""
" MAPPINGS
""""""""""""""""

call MakePrefix('explorer', '<:prefix>F')

noremap <leader>f :call OpenRanger('')<CR>
noremap <leader>F :call OpenRanger('%:p:h')<CR>

noremap <:explorer><space> :call OpenRanger('')<CR>
