local lang = Module.new("lang", "<space>l")

pack "neovim/nvim-lspconfig"
pack { src = "nvim-treesitter/nvim-treesitter", version = "main" }

--
-- SETTINGS
--

vim.opt.foldmethod = "expr"

--
-- SETUP
--

-- syntax

local trees = require "nvim-treesitter"
trees.install({
	"lua",
	"nu",
})

-- lsp

vim.lsp.config("lua_ls", {
	on_init = function(client)
		if client.workspace_folders then
			local path = client.workspace_folders[1].name
			if
				path ~= vim.fn.stdpath("config")
				and (vim.uv.fs_stat(path .. "/.luarc.json") or vim.uv.fs_stat(path .. "/.luarc.jsonc"))
			then
				return
			end
		end

		client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
			runtime = {
				version = "LuaJIT",
				path = {
					"lua/?.lua",
					"lua/?/init.lua",
				},
			},
			workspace = {
				checkThirdParty = false,
				library = {
					vim.env.VIMRUNTIME,
				},
			},
		})
	end,

	settings = {
		Lua = {},
	},
})

vim.lsp.enable("lua_ls")
vim.lsp.enable("nushell")

--
-- MAPPINGS
--

map("<localleader>=", vim.lsp.buf.format)

--
-- EVENTS
--

vim.api.nvim_create_autocmd("LspAttach", {
	group = lang.group,
	callback = function(event)
		local client = vim.lsp.get_client_by_id(event.data.client_id)
		if client:supports_method("textDocument/completion") then
			vim.lsp.completion.enable(true, client.id, event.buf, { autotrigger = true })
		end
	end,
})
