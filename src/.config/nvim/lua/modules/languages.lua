local languages = Module.new("languages", "<space>l")

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
local langs = {
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
trees.install(langs)

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

--
-- MAPPINGS
--

map("<localleader>=", vim.lsp.buf.format)

--
-- EVENTS
--

-- enable language features
vim.api.nvim_create_autocmd("FileType", {
	group = languages.group,
	pattern = langs,
	callback = function()
		vim.treesitter.start()
		vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
		vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
	end,
})

-- enable lsp completion
vim.api.nvim_create_autocmd("LspAttach", {
	group = languages.group,
	callback = function(event)
		local client = vim.lsp.get_client_by_id(event.data.client_id)
		if client == nil then return end
		if client:supports_method("textDocument/completion") then
			vim.lsp.completion.enable(true, client.id, event.buf, { autotrigger = true })
		end
	end,
})
