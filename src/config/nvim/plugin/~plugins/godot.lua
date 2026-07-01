local godot = Module.new("godot", "<space>g")

pack("Mathijs-Bakker/godotdev.nvim", {
	"mfussenegger/nvim-dap",
	"rcarriga/nvim-dap-ui",
	"nvim-treesitter/nvim-treesitter",
})

--
-- SETUP
--

require("godotdev").setup()

--
-- LOAD
--

local project_file = vim.fn.getcwd() .. "/project.godot"
local socket_file = "./.sock"

if vim.uv.fs_stat(project_file) then
	if not vim.uv.fs_stat(socket_file) then
		vim.fn.serverstart(socket_file)
	end
end

--
-- MAPPINGS
--

godot:map("d", cmd "GodotDocs")
