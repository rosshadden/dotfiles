" prefix
call MakePrefix('plugins', '<:prefix>P')

" update
noremap <:plugins>u :PlugUpdate<cr>
noremap <:plugins>U :PlugUpdate!<cr>

" upgrade
noremap <:plugins>p :PlugUpgrade<cr>

" install
noremap <:plugins>i :PlugInstall<cr>
noremap <:plugins>I :PlugInstall!<cr>

" clean
noremap <:plugins>c :PlugClean<cr>
noremap <:plugins>C :PlugClean!<cr>

" status
noremap <:plugins>s :PlugStatus<cr>

" diff
noremap <:plugins>d :PlugDiff<cr>
