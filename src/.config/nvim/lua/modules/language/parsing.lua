local language = Module.new("language", "<space>l")

pack { src = "nvim-treesitter/nvim-treesitter", version = "main" }
pack { src = "nvim-treesitter/nvim-treesitter-textobjects", version = "main" }

--
-- SETTINGS
--

vim.opt.foldmethod = "expr"

--
-- SETUP
--

-- syntax

vim.filetype.add({
	extension = {
		bb = "clojure",
		conf = "config",
		gdt = "gdscript",
		nuon = "nu",
		yuck = "clojure",
		vtmpl = "v",
		zon = "zig",
	},
})

local trees = require "nvim-treesitter"
local languages = {
	"bash",
	"c",
	"c_sharp",
	"clojure",
	"cpp",
	"css",
	"dockerfile",
	"gdscript",
	"go",
	"godot_resource",
	"html",
	"janet_simple",
	"javascript",
	"json",
	"julia",
	"lua",
	"markdown",
	"nim",
	"nu",
	"odin",
	"php",
	"proto",
	"python",
	"rust",
	"terraform",
	"toml",
	"tsx",
	"typescript",
	"v",
	"yaml",
	"zig",
}
trees.install(languages)

--
-- MAPPINGS
--

local ts_select = require("nvim-treesitter-textobjects.select").select_textobject
map("aa", call(ts_select, "@parameter.outer", "textobjects"), { "x", "o" })
map("ia", call(ts_select, "@parameter.inner", "textobjects"), { "x", "o" })
map("af", call(ts_select, "@function.outer", "textobjects"), { "x", "o" })
map("if", call(ts_select, "@function.inner", "textobjects"), { "x", "o" })
map("ac", call(ts_select, "@class.outer", "textobjects"), { "x", "o" })
map("ic", call(ts_select, "@class.inner", "textobjects"), { "x", "o" })
map("aC", call(ts_select, "@conditional.outer", "textobjects"), { "x", "o" })
map("iC", call(ts_select, "@conditional.inner", "textobjects"), { "x", "o" })
map("aS", call(ts_select, "@local.scope", "locals"), { "x", "o" })

local ts_swap = require("nvim-treesitter-textobjects.swap")
language:map("al", call(ts_swap.swap_next, "@parameter.inner"))
language:map("ah", call(ts_swap.swap_previous, "@parameter.inner"))
language:map("Al", call(ts_swap.swap_next, "@parameter.outer"))
language:map("Ah", call(ts_swap.swap_previous, "@parameter.outer"))

local ts_move = require("nvim-treesitter-textobjects.move")
map("[e", call(ts_move.goto_previous_start, { "@loop.inner", "@loop.outer" }, "textobjects"), { "n", "x", "o" })
map("]e", call(ts_move.goto_next_start, { "@loop.inner", "@loop.outer" }, "textobjects"), { "n", "x", "o" })
map("[r", call(ts_move.goto_previous_start, "@return.outer", "textobjects"), { "n", "x", "o" })
map("]r", call(ts_move.goto_next_start, "@return.outer", "textobjects"), { "n", "x", "o" })
map("[R", call(ts_move.goto_previous_start, "@regex.outer", "textobjects"), { "n", "x", "o" })
map("]R", call(ts_move.goto_next_start, "@regex.outer", "textobjects"), { "n", "x", "o" })
map("[s", call(ts_move.goto_previous_start, "@local.scope", "locals"), { "n", "x", "o" })
map("]s", call(ts_move.goto_next_start, "@local.scope", "locals"), { "n", "x", "o" })
map("[z", call(ts_move.goto_previous_start, "@fold", "folds"), { "n", "x", "o" })
map("]z", call(ts_move.goto_next_start, "@fold", "folds"), { "n", "x", "o" })

--
-- EVENTS
--

-- enable language features
vim.api.nvim_create_autocmd("FileType", {
	group = language.group,
	pattern = languages,
	callback = function()
		vim.treesitter.start()
		vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
		vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
	end,
})
