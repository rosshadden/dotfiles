--
-- SETTINGS
--

-- line numbers
vim.opt.number = true

-- colorscheme
require("base16-colorscheme").setup("paraiso")

vim.cmd [[
	" transparency
	highlight Normal guibg=none
	highlight NormalNC guibg=none
	highlight NormalFloat guibg=none
	highlight LineNr guibg=none
	highlight SignColumn guibg=none

	" search
	highlight Search guibg=#41323f guifg=#fec418
	highlight IncSearch guibg=#41323f guifg=#ef6155
]]

-- TODO: slow as hell
-- require("mini.starter").setup()

--
-- FUNCTIONS
--

-- highlight on yank
vim.cmd [[
	augroup YankHighlight
		autocmd!
		autocmd TextYankPost * silent! lua vim.highlight.on_yank()
	augroup end
]]
