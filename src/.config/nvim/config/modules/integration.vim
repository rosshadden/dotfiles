" firenvim

if exists('g:started_by_firenvim')
	set laststatus=0

	augroup integration
		autocmd BufEnter github.com_*.txt set filetype=markdown
	augroup END

	let g:firenvim_config = {
		\ 'globalSettings': {
			\ 'alt': 'all',
			\ '<C-w>': 'noop',
		\  },
		\ 'localSettings': {
			\ '.*': {
				\ 'cmdline': 'neovim',
				\ 'priority': 0,
				\ 'selector': 'textarea',
				\ 'takeover': 'never',
			\ },
		\ }
	\ }
endif
