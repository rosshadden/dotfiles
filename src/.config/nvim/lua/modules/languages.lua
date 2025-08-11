local langs = Module.new("languages", "<space>l")

pack "neovim/nvim-lspconfig"
pack "zbirenbaum/copilot.lua"
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

-- lsp

local servers = {
	"bashls",
	"csharp_ls",
	"emmylua_ls",
	"gdscript",
	"gdshader_lsp",
	"gopls",
	"jsonls",
	"julials",
	"nickel_ls",
	"nim_langserver",
	"nushell",
	"ols",
	"pylsp",
	"rust_analyzer",
	"sourcekit",
	"ts_ls",
	"v_analyzer",
	"zls",
}
vim.lsp.enable(servers)

vim.lsp.config("pylsp", {
	settings = {
		pylsp = {
			plugins = {
				pycodestyle = {
					ignore = { "E501" },
				},
			},
		},
	},
})

vim.lsp.config("emmylua_ls", {
	settings = {
		Lua = {
			runtime = {
				version = "LuaJIT",
				requirePattern = {
					"lua/?.lua",
					"lua/?/init.lua",
				}
			},
			workspace = {
				checkThirdParty = false,
				library = { vim.env.VIMRUNTIME },
			},
		},
	},
})

local mini_snippets = require("mini.snippets")
mini_snippets.setup({
	snippets = {
		mini_snippets.gen_loader.from_file("~/.config/nvim/snippets/global.lua"),
		mini_snippets.gen_loader.from_lang(),
	},
	mappings = {
		expand = "<c-.>",
		jump_next = "<right>",
		jump_prev = "<left>",
	},
})
mini_snippets.start_lsp_server({ match = false })

require("copilot").setup({
	suggestion = { enabled = false },
	panel = { enabled = false },
})

--
-- MAPPINGS
--

map("<localleader>=", vim.lsp.buf.format)

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
langs:map("al", call(ts_swap.swap_next, "@parameter.inner"))
langs:map("ah", call(ts_swap.swap_previous, "@parameter.inner"))
langs:map("Al", call(ts_swap.swap_next, "@parameter.outer"))
langs:map("Ah", call(ts_swap.swap_previous, "@parameter.outer"))

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

local function completion_mappings()
	-- Use enter to accept completions.
	map("<cr>", function()
		return pumvisible() and "<c-y>" or "<cr>"
	end, "i", { expr = true })

	-- Use <c-n> to navigate to the next completion or:
	-- - Trigger LSP completion.
	-- - If there"s no one, fallback to vanilla omnifunc.
	map("<c-n>", function()
		if pumvisible() then
			feedkeys "<c-n>"
		else
			if next(vim.lsp.get_clients { bufnr = 0 }) then
				vim.lsp.completion.get()
			else
				if vim.bo.omnifunc == "" then
					feedkeys "<c-x><c-n>"
				else
					feedkeys "<c-x><c-o>"
				end
			end
		end
	end, "i")

	-- Use <tab> to accept a Copilot suggestion, navigate between snippet tabstops,
	-- or select the next completion.
	-- Do something similar with <s-tab>.
	map("<tab>", function()
		local copilot = require "copilot.suggestion"

		if copilot.is_visible() then
			copilot.accept()
		elseif pumvisible() then
			feedkeys "<c-n>"
		elseif vim.snippet.active { direction = 1 } then
			vim.snippet.jump(1)
		else
			feedkeys "<tab>"
		end
	end, { "i", "s" })
	map("<s-tab>", function()
		if pumvisible() then
			feedkeys "<c-p>"
		elseif vim.snippet.active { direction = -1 } then
			vim.snippet.jump(-1)
		else
			feedkeys "<s-tab>"
		end
	end, { "i", "s" })

	-- Inside a snippet, use backspace to remove the placeholder.
	map("<bs>", "<c-o>s", "s")
end

--
-- EVENTS
--

-- enable language features
vim.api.nvim_create_autocmd("FileType", {
	group = langs.group,
	pattern = languages,
	callback = function()
		vim.treesitter.start()
		vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
		vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
	end,
})

-- enable lsp completion
vim.api.nvim_create_autocmd("LspAttach", {
	group = langs.group,
	callback = function(event)
		local client = vim.lsp.get_client_by_id(event.data.client_id)
		if client == nil then return end
		if client:supports_method("textDocument/completion") then
			vim.lsp.completion.enable(true, client.id, event.buf, { autotrigger = true })
			completion_mappings()
		end
	end,
})
