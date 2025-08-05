--
-- SETTINGS
--

vim.opt.shiftwidth = 0
vim.opt.tabstop = 2
vim.opt.swapfile = false

--
-- SETUP
--

require("mini.align").setup()
require("mini.bracketed").setup()
require("mini.extra").setup()
require("mini.indentscope").setup()
require("mini.splitjoin").setup()
require("mini.surround").setup()
require("mini.trailspace").setup()


require("mini.basics").setup({
	extra_ui = true,
})

require("mini.operators").setup({
	replace = {
		prefix = "g.",
	},
})

require("mini.ai").setup({
	custom_textobjects = {
		-- current line/row
		r = MiniExtra.gen_ai_spec.line(),

		-- entire buffer
		e = function()
			local from = { line = 1, col = 1 }
			local to = {
				line = vim.fn.line('$'),
				col = math.max(vim.fn.getline('$'):len(), 1)
			}
			return { from = from, to = to, vis_mode = 'V' }
		end
	}
})

--
-- MAPPINGS
--

-- enhancements

-- redo
map("U", "<c-r>", { noremap = true })
-- find
map("<a-/>", "/\\v", { modes = "", noremap = true })
