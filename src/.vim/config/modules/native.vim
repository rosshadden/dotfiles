""""""""""""""""
" MAPPINGS
""""""""""""""""

" expose the native mappings I've stolen
" TODO: abstract this a bit, perhaps a function that takes an array of keys to fix
" TODO: independent of above, maybe I should fix all keys, instead of maintaining a list
noremap <:leader:1>Y Y
noremap <:leader:1>s s
noremap <:leader:1>S S
noremap <:leader:1>U U
noremap <:leader:1>Q Q
noremap <:leader:1>< <
noremap <:leader:1>> >
noremap <:leader:1>; ;
noremap <:leader:1>, ,
noremap <:leader:1>- -
noremap <:leader:1><space> <space>

" fix <<, since I stole `<`
noremap << <<
