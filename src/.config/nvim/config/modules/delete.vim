" prefix
call MakePrefix('delete', '<:prefix>d')

" line
noremap <:delete>d cc<esc>

" cardinal
noremap <:delete>h dh
noremap <:delete>l ldlh
noremap <:delete>j mDjdd`D
noremap <:delete>k kdd

" horizontal
map <:delete>s <:delete>h<:delete>l
" vertical
map <:delete>v <:delete>j<:delete>k
