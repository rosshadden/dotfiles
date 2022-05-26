local configs = require "nvim-treesitter.configs"
local ft = require "Comment.ft"
local lsp = require "lspconfig"
local lspUtils = require "lspconfig.util"
local parsers = require("nvim-treesitter.parsers").get_parser_configs()

--
-- SETTINGS
--

vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"

vim.g["plantuml_previewer#plantuml_jar_path"] = "/usr/share/java/plantuml/plantuml.jar"

ft.set("gdscript", "#%s")

--
-- SETUP
--

parsers.norg_meta = {
	install_info = {
		url = "https://github.com/nvim-neorg/tree-sitter-norg-meta",
		files = { "src/parser.c" },
		branch = "main",
	},
}

parsers.norg_table = {
	install_info = {
		url = "https://github.com/nvim-neorg/tree-sitter-norg-table",
		files = { "src/parser.c" },
		branch = "main",
	},
}

--
-- SYNTAX
--

configs.setup {
	ensure_installed = {
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
		"javascript",
		"json",
		"kotlin",
		"lua",
		"markdown",
		"norg",
		"php",
		"python",
		"rust",
		"toml",
		"tsx",
		"typescript",
		"yaml",

		-- custom
		"norg_meta",
		"norg_table",
		"nu",
	},

	highlight = { enable = true },
	incremental_selection = { enable = true },
	indent = { enable = true },

	textobjects = {
		select = {
			enable = true,

			lookahead = true,

			keymaps = {
				["if"] = "@function.inner",
				["af"] = "@function.outer",
				["ic"] = "@class.inner",
				["ac"] = "@class.outer",
				["ia"] = "@parameter.inner",
				["aa"] = "@parameter.outer",
				["iC"] = "@conditional.inner",
				["aC"] = "@conditional.outer",
				["i/"] = "@comment.outer",
				["a/"] = "@comment.outer",
			},
		},

		swap = {},

		move = {
			enable = true,

			set_jumps = true,

			goto_next_start = {
				["]m"] = "@function.outer",
				["]]"] = "@class.outer",
			},
			goto_next_end = {
				["]M"] = "@function.outer",
				["]["] = "@class.outer",
			},
			goto_previous_start = {
				["[m"] = "@function.outer",
				["[["] = "@class.outer",
			},
			goto_previous_end = {
				["[M"] = "@function.outer",
				["[]"] = "@class.outer",
			},
		},
	},
}

--
-- LSP
--

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

local onAttach = function(_, bufnr)
	vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
end

local servers = {
	"bashls",
	"gdscript",
	"gopls",
	"rust_analyzer",
	"tsserver",
}
for _, server in ipairs(servers) do
	lsp[server].setup {
		on_attach = onAttach,
		capabilities = capabilities,
	}
end

-- lua
-- TODO: support doing this in the above loop, pulling and merging additional config
local rtp = vim.split(package.path, ";")
table.insert(rtp, "lua/?.lua")
table.insert(rtp, "lua/?/init.lua")
lsp.sumneko_lua.setup {
	on_attach = onAttach,
	capabilities = capabilities,
	root_dir = function(file)
		return lspUtils.find_git_ancestor(file) or lspUtils.path.dirname(file)
	end,
	settings = {
		Lua = {
			runtime = {
				version = "LuaJIT",
				path = rtp,
			},
			diagnostics = {
				globals = { "vim" },
			},
			workspace = {
				library = vim.api.nvim_get_runtime_file("", true),
				checkThirdParty = false,
			},
		},
	},
}
