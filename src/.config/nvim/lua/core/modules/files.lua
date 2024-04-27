local fm = require("fm-nvim")
local mini_files = require("mini.files")
local mini_pick = require("mini.pick")
local telescope = require("telescope.builtin")

--
-- SETUP
--

mini_files.setup()
mini_pick.setup()

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

-- pick
vim.keymap.set("n", "<plug><files><tab>", function()
	mini_files.open()
end, { silent = true })

-- choose
vim.keymap.set("n", "<plug><files>c", telescope.find_files, { silent = true })

-- git
vim.keymap.set("n", "<plug><files>g", telescope.git_files, { silent = true })

-- search
vim.keymap.set("n", "<plug><files>s", telescope.live_grep, { silent = true })
