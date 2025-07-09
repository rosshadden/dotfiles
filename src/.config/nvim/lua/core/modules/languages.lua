local trees = require "nvim-treesitter.configs"
local lsp = require "lspconfig"
local lspUtils = require "lspconfig.util"

--
-- SETTINGS
--

vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"

vim.g["plantuml_previewer#plantuml_jar_path"] = "/usr/share/java/plantuml/plantuml.jar"

--
-- SETUP
--

require("mini.comment").setup()

vim.filetype.add({
	extension = {
		bb = "clojure",
		conf = "config",
		gdt = "gdscript",
		nu = "nu",
		nuon = "nu",
		yuck = "clojure",
		vtmpl = "v",
		zon = "zig",
	},
})

--
-- SYNTAX
--

trees.setup {
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
		"janet_simple",
		"javascript",
		"json",
		"julia",
		"lua",
		"markdown",
		"nim",
		"nu",
		"php",
		"proto",
		"python",
		"rust",
		"terraform",
		"toml",
		"tsx",
		"typescript",
		"typst",
		"v",
		"yaml",
		"zig",
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
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

local on_attach = function(_, bufnr)
	vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
end

local servers = {
	"bashls",
	"csharp_ls",
	"gdscript",
	"gdshader_lsp",
	"gopls",
	"jsonls",
	"julials",
	"nickel_ls",
	"nim_langserver",
	"nushell",
	-- "rust_analyzer",
	"sourcekit",
	"tinymist",
	"ts_ls",
	"v_analyzer",
	"zls",
}
for _, server in ipairs(servers) do
	lsp[server].setup {
		on_attach = on_attach,
		capabilities = capabilities,
	}
end

-- lua
-- TODO: support doing this in the above loop, pulling and merging additional config
local rtp = vim.split(package.path, ";")
table.insert(rtp, "lua/?.lua")
table.insert(rtp, "lua/?/init.lua")
lsp.lua_ls.setup {
	on_attach = on_attach,
	capabilities = capabilities,
	root_dir = function(file)
		return vim.fs.dirname(vim.fs.find('.git', { path = file, upward = true })[1]) or vim.fs.dirname(file)
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

-- python
lsp.pylsp.setup {
	settings = {
		pylsp = {
			plugins = {
				pycodestyle = {
					ignore = { "E501" },
				},
			},
		},
	},
}
