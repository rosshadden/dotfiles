local completion = Module.new("completion")

pack "neovim/nvim-lspconfig"
pack "zbirenbaum/copilot.lua"

--
-- SETUP
--

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

-- snippets

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

-- enable lsp completion
vim.api.nvim_create_autocmd("LspAttach", {
	group = completion.group,
	callback = function(event)
		local client = vim.lsp.get_client_by_id(event.data.client_id)
		if client == nil then return end
		if client:supports_method("textDocument/completion") then
			vim.lsp.completion.enable(true, client.id, event.buf, { autotrigger = true })
			completion_mappings()
		end
	end,
})
