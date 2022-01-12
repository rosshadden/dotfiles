--
-- settings
--

vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"

--
-- syntax
--

local configs = require "nvim-treesitter.configs"

configs.setup {
	ensure_installed = {
		"bash",
		"c",
		"c_sharp",
		"clojure",
		"cpp",
		"dockerfile",
		"gdscript",
		"go",
		"godot_resource",
		"html",
		"javascript",
		"json",
		"lua",
		"php",
		"python",
		"toml",
		"tsx",
		"typescript",
		"yaml",

		"nu",
	},
	highlight = { enable = true },
	incremental_selection = { enable = true },
	indent = { enable = true },
	textobjects = { enable = true },
}

--
-- LSP
--

local lsp = require "lspconfig"
local lspUtils = require "lspconfig.util"

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

local onAttach = function(_, bufnr)
	vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
end

local servers = { "gdscript", }
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
