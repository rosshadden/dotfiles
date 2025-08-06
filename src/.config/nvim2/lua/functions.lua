--- Map wrapper.
function map(seq, action, modes, cfg)
	modes = modes or "n"
	cfg = cfg or {}

	if cfg.silent == nil then cfg.silent = true end

	vim.keymap.set(modes, seq, action, cfg)
end

--- Helper function to make nvim commands for mapping.
--- @return string :name<cr>
function cmd(name)
	return ":" .. name .. "<cr>"
end

--- Process and flatten plugin specs.
local function process(v, result)
	if type(v) == "table" and not v.src and #v > 0 then
		for _, item in ipairs(v) do process(item, result) end
	else
		if type(v) == "string" and not v:match("^https?:") then
			v = "https://github.com/" .. v
		elseif type(v) == "table" and v.src and not v.src:match("^https?:") then
			v.src = "https://github.com/" .. v.src
		end
		table.insert(result, v)
	end
end

--- Add packages.
function pack(...)
	local specs = {}
	for _, arg in ipairs({...}) do process(arg, specs) end
	return vim.pack.add(specs)
end
