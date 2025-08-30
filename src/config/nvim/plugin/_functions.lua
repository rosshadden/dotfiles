--- Map wrapper.
--- FIX: these should be passing "" to map, not "n". map needs to check for nil or something
--- @param seq string
--- @param action string|function
--- @param mode? string|string[]
--- @param cfg? string|table
function map(seq, action, mode, cfg)
	mode = mode or "n"
	cfg = cfg or {}

	if cfg.silent == nil then cfg.silent = true end

	vim.keymap.set(mode, seq, action, cfg)
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
	for _, arg in ipairs({ ... }) do process(arg, specs) end
	return vim.pack.add(specs)
end

--- Wrap a function call with args, making mappings easier.
function call(fn, ...)
	local args = { ... }
	return function() fn(unpack(args)) end
end

--- For replacing certain <c-x>... keymaps.
--- @param keys string
function feedkeys(keys)
	vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(keys, true, false, true), "n", true)
end

--- Is the completion menu open?
function pumvisible()
	return tonumber(vim.fn.pumvisible()) ~= 0
end

--- Run command with shell.
--- @param cmd string The command to run.
--- @param shell string? Shell override.
--- @return vim.SystemObj
function run(cmd, shell)
	if shell == nil then shell = vim.o.shell end
	return vim.system({ shell, vim.o.shellcmdflag, cmd })
end

-- TODO: make a helper for toggling settings
