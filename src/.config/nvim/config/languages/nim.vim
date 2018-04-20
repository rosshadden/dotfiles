""""""""""""""""
" SETTINGS
""""""""""""""""

" let g:nvim_nim_highlighter_enable = 1

call tcomment#type#Define('nim', '# %s')

""""""""""""""""
" MISC
""""""""""""""""

augroup nim
	autocmd!
	autocmd BufEnter,BufNew *.nimble setlocal ft=nims | setlocal expandtab
augroup END

fun! JumpToDef()
	if exists("*GotoDefinition_" . &filetype)
		call GotoDefinition_{&filetype}()
	else
		exe "norm! \<C-]>"
	endif
endf

" Jump to tag
nn <M-g> :call JumpToDef()<cr>
ino <M-g> <esc>:call JumpToDef()<cr>i
