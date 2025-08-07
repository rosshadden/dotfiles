local project_file = vim.fn.getcwd() .. "/project.godot"
local socket_file = "./.sock"

if vim.uv.fs_stat(project_file) then
	if not vim.uv.fs_stat(socket_file) then
		vim.fn.serverstart(socket_file)
	end
end
