local lsp = require "lspconfig"
local lspUtils = require "lspconfig.util"

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

local onAttach = function(_, bufnr)
	vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
end

local rtp = vim.split(package.path, ";")
table.insert(rtp, "lua/?.lua")
table.insert(rtp, "lua/?/init.lua")

-- TODO: do these in a loop, pulling and merging additional config if applicable

lsp.sumneko_lua.setup{
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

lsp.gdscript.setup{
	on_attach = onAttach,
	capabilities = capabilities,
}
