""""""""""""""""
" SETTINGS
""""""""""""""""

call unite#custom#profile('files', 'context', {
	\ 'unique': 1,
	\ 'candidate_icon': '>',
\ })


""""""""""""""""
" MAPPINGS
""""""""""""""""

call MakePrefix('files', '<:prefix>f')
call MakePrefix('files', '<:files>f', 1)

" flat
nnoremap <:files>s :Unite -buffer-name=files directory file/async file/new directory/new<cr>
nnoremap <:files>S :UniteWithBufferDir -buffer-name=files directory file/async file/new directory/new<cr>

" recursive
nnoremap <:files>r :Unite              -buffer-name=files -start-insert file_rec/async:!<cr>
nnoremap <:files>R :UniteWithBufferDir -buffer-name=files -start-insert file_rec/async:!<cr>

" most recently used (mru) files
nnoremap <:files>m :Unite              -buffer-name=recent file_mru<cr>
nnoremap <:files>M :UniteWithBufferDir -buffer-name=recent file_mru<cr>
nnoremap <:files:1>m :Unite              -buffer-name=recent -silent -force-immediately file_mru:UniteFirst<cr>
nnoremap <:files:1>M :UniteWithBufferDir -buffer-name=recent -silent -force-immediately file_mru<cr>
