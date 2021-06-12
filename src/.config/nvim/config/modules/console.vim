""""""""""""""""
" MAPPINGS
""""""""""""""""

" :W => write with sudo
command! W :exec ':silent w !sudo tee % > /dev/null' | :edit!

command! FixIndentation call FixIndentation()

" reload vimrc config
command! Reload :exec 'source ' . g:configFile . ' | redraw! | echo "Vim config reloaded."'

" change Working Directory to that of the current file
command! CWD lcd %:p:h

" diff unsaved changes
command! DiffChanges vert new | set bt=nofile | r ++edit # | 0d_ | diffthis | wincmd p | diffthis
