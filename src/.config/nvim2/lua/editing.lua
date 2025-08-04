vim.opt.shiftwidth = 0
vim.opt.tabstop = 2
vim.opt.swapfile = false

require("mini.basics").setup({
	extra_ui = true,
})

require("mini.align").setup()
require("mini.surround").setup()
require("mini.trailspace").setup()

-- enhancements

-- redo
map("U", "<c-r>", { noremap = true })
-- find
map("<a-/>", "/\\v", { modes = "", noremap = true })
