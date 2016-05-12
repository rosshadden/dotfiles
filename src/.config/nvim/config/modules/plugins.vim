" prefix
call MakePrefix('plugins', '<:prefix>P')
call MakePrefix('plugins', '<:plugins>P', 1)

" update
noremap <:plugins>u :PlugUpdate<cr>
noremap <:plugins>U :PlugUpgrade<cr>
noremap <:plugins:1>u :PlugUpdate \| PlugUpgrade<cr>

" install
noremap <:plugins>i :PlugInstall<cr>

" clean
noremap <:plugins>c :PlugClean<cr>

" status
noremap <:plugins>s :PlugStatus<cr>

" diff
noremap <:plugins>d :PlugDiff<cr>
