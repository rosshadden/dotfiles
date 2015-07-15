" prefix
call MakePrefix('delete', '[prefix]d')

" up, down, left, right
noremap [delete]h dh
noremap [delete]l ldlh
noremap [delete]j mDjdd`D
noremap [delete]k mDkdd`D

" horizontal
map [delete]s [delete]h[delete]l
" vertical
map [delete]v [delete]j[delete]k
