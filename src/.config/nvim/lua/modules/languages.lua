local languages = Module.new("languages", "<space>l")

pack "neovim/nvim-lspconfig"
pack "zbirenbaum/copilot.lua"
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

require("copilot").setup({
	suggestion = { enabled = false },
	panel = { enabled = false },
})
--
-- FUNCTIONS
--

--- For replacing certain <c-x>... keymaps.
--- @param keys string
local function feedkeys(keys)
	vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(keys, true, false, true), "n", true)
end

--- Is the completion menu open?
local function pumvisible()
	return tonumber(vim.fn.pumvisible()) ~= 0
end

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
			completion_mappings()
		end
	end,
})
