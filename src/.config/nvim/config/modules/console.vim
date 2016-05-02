""""""""""""""""
" MAPPINGS
""""""""""""""""

" :W => write with sudo
command! W :execute ':silent w !sudo tee % > /dev/null' | :edit!

" reload vimrc config
command! Reload source g:configFile | redraw! | echo 'Vim config reloaded.' | AirlineRefresh

" change Working Directory to that of the current file
command! CWD lcd %:p:h

" diff unsaved changes
command! DiffChanges vert new | set bt=nofile | r ++edit # | 0d_ | diffthis | wincmd p | diffthis

command! FixSettings call FixSettings()
