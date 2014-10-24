" :W => write with sudo
command! W :execute ':silent w !sudo tee % > /dev/null' | :edit!

" reload vimrc config
command! Reload source ~/.vim/vimrc

" change Working Directory to that of the current file
command! CWD lcd %:p:h

" diff unsaved changes
if !exists(":DiffChanges")
	command DiffChanges vert new | set bt=nofile | r ++edit # | 0d_ | diffthis | wincmd p | diffthis
endif
