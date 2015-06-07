" Make multiple cursors fast with neocomplete

function! Multiple_cursors_before()
	exe 'NeoCompleteLock'
endfunction

function! Multiple_cursors_after()
	exe 'NeoCompleteUnlock'
endfunction
