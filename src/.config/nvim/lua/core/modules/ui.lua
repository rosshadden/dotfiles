local starter = require "mini.starter"

--
-- SETTINGS
--

-- line numbers
vim.opt.number = true

-- status
vim.opt.laststatus = 3
vim.opt.winbar = "%=%m %f"

-- concealment
vim.opt.conceallevel = 2
vim.opt.concealcursor = "nv"

-- colorscheme
vim.opt.termguicolors = true
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

-- -- startup menu
-- require("mini.starter").setup({
-- 	items = {
-- 		starter.sections.recent_files(10, true),
-- 		starter.sections.telescope(),
-- 		starter.sections.builtin_actions(),
-- 	}
-- })

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
