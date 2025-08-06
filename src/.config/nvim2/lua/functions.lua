--- Map wrapper.
function map(seq, action, cfg)
	cfg = cfg or {}

	local modes = cfg.modes or "n"
	local options = {
		silent = cfg.silent == nil and true or cfg.silent,
		noremap = cfg.noremap == nil and false or cfg.noremap,
		desc = cfg.desc,
		expr = cfg.expr,
		nowait = cfg.nowait,
		unique = cfg.unique,
		replace_keycodes = cfg.replace_keycodes,
		callback = cfg.callback,
		buffer = cfg.buffer,
	}

	-- make commands noremap
	if type(action) ~= "string" or action:sub(1, 1) == ":" then
		options.noremap = true
	end

	vim.keymap.set(modes, seq, action, options)
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
