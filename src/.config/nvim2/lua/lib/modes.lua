--- Struct allowing mode-specific keymaps.
Mode = {
	name = "",
	seq = "",
	prefix = "",
	group = nil,
}

--- Create a Mode.
function Mode.new(name, seq)
	local self = setmetatable(Mode, Mode)
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
function Mode:map(seq, action, cfg)
	map(self.prefix .. seq, action, cfg)
end
