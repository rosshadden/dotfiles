local telescope = require("telescope.builtin")
local fm = require("fm-nvim")

fm.setup {
	mappings = {
		vert_split = "<c-l>",
		horz_split = "<c-j>",
	},
	ui = {
		split = {
			direction = "rightbelow",
		},
	},
}

-- prefix
vim.keymap.set("n", "<space>f", "<plug><files>", { silent = true })

-- open file browser at file's cwd
vim.keymap.set("n", "<plug><files><space>", function()
	fm.Ranger(vim.fn.expand("%:p:h"))
end, { silent = true })
-- open file browser at editor's cwd
vim.keymap.set("n", "<plug><files><a-space>", fm.Ranger, { silent = true })

-- list
vim.keymap.set("n", "<plug><files>l", telescope.find_files, { silent = true })

-- git
vim.keymap.set("n", "<plug><files>g", telescope.git_files, { silent = true })
