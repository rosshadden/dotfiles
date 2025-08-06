--- Struct allowing mode-specific keymaps.
Module = {
	name = "",
	seq = "",
	prefix = "",
	group = nil,
}

--- Create a Mode.
function Module.new(name, seq)
	local self = setmetatable(Module, Module)
	self.name = name
	self.seq = seq
	self.prefix = "<plug>(" .. self.name .. ")"
	self.group = vim.api.nvim_create_augroup(self.name, {})

	if seq ~= nil then
		map(self.seq, self.prefix)
	end

	return self
end

--- Map key in mode.
function Module:map(seq, action, modes, cfg)
	map(self.prefix .. seq, action, modes, cfg)
end

require "modules.app"
require "modules.buffers"
require "modules.code"
require "modules.debug"
require "modules.files"
require "modules.languages"
require "modules.packages"
require "modules.registers"
require "modules.spans"
require "modules.tabs"
require "modules.templates"
require "modules.ui"
require "modules.vcs"
