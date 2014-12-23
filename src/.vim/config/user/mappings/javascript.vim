augroup javascript
	" insert debugger
	autocmd FileType javascript
		\ nmap <localleader>d o<esc>idebugger;<esc>

	" insert section comment
	autocmd FileType javascript
		\ nmap <localleader>cs o////////////////<esc>yypO <esc>
augroup END
