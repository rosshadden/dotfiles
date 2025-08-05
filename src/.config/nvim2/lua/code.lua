local code = Mode.new("code")

--
-- SETTINGS
--

vim.opt.shiftwidth = 0
vim.opt.tabstop = 2
vim.opt.swapfile = false

--
-- SETUP
--

require "mini.align".setup()
require "mini.splitjoin".setup()
require "mini.surround".setup()
require "mini.trailspace".setup()

require "mini.move".setup({
	mappings = {
		down = "<down>",
		left = "<left>",
		right = "<right>",
		up = "<up>",

		line_down = "<down>",
		line_left = "<left>",
		line_right = "<right>",
		line_up = "<up>",
	}
})

--
-- MAPPINGS
--

-- enhancements

-- redo
map("U", "<c-r>", { noremap = true })
-- find
map("<leader>/", "/\\v", { modes = "", silent = false, noremap = true })

--
-- EVENTS
--

-- preserve cursor position [:h restore-cursor]
vim.api.nvim_create_autocmd("BufRead", {
	group = code.group,
	command = [[
		if line("'\"") > 1 && line("'\"") <= line("$") | exec "normal! g`\"" | endif
	]],
})
