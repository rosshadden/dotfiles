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

	" whitespace
	highlight NonText guifg=#444444

	" search
	highlight Search guibg=#41323f guifg=#fec418
	highlight IncSearch guibg=#41323f guifg=#ef6155
]]

-- TODO: slow as hell
-- require("mini.starter").setup()

--
-- FUNCTIONS
--

local group = vim.api.nvim_create_augroup("yank-highlight", {})

-- highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
	group = group,
	callback = function()
		vim.highlight.on_yank()
	end,
})
