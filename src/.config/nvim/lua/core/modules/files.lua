local telescope = require("telescope.builtin")
local fm = require("fm-nvim")

--
-- MAPPINGS
--

-- prefix
vim.keymap.set("n", "<space>f", "<plug><files>", { silent = true })

-- open file browser at file's cwd
vim.keymap.set("n", "<plug><files><space>", function()
	fm.Lf(vim.fn.expand("%:p:h"))
end, { silent = true })
-- open file browser at editor's cwd
vim.keymap.set("n", "<plug><files><a-space>", fm.Lf, { silent = true })

-- TODO: remove ranger
-- open file browser at file's cwd
vim.keymap.set("n", "<plug><files>r", function()
	fm.Ranger(vim.fn.expand("%:p:h"))
end, { silent = true })
-- open file browser at editor's cwd
vim.keymap.set("n", "<plug><files>R", fm.Ranger, { silent = true })

-- choose
vim.keymap.set("n", "<plug><files>c", telescope.find_files, { silent = true })

-- git
vim.keymap.set("n", "<plug><files>g", telescope.git_files, { silent = true })

-- search
vim.keymap.set("n", "<plug><files>s", telescope.live_grep, { silent = true })

--
-- SETUP
--

fm.setup {
	mappings = {
		vert_split = "<a-l>",
		horz_split = "<a-j>",
		tabedit = "<a-t>",
	},
	ui = {
		split = {
			direction = "rightbelow",
		},
		float = {
			border = { "╔", "═" ,"╗", "║", "╝", "═", "╚", "║" },
		},
	},
}

