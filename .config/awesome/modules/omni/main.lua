--
local _ = require("modules/_")
local util = require("modules/util")
--


local omni = {}


local plugins = {}
omni.register = function(namespace, plugin)
	plugins[namespace] = plugin

	-- support aliases
	if plugin.alias then
		if type(plugin.alias) == 'string' then plugin.alias = { plugin.alias } end

		_.each(plugin.alias, function(alias)
			plugins[alias] = plugin
		end)
	end
end

omni.open = function()
	local keys = _.map(_.keys(plugins), function(key)
		return key --.. ':'
	end)

	omni.prompt(keys, function(value)
		if #value == 0 then return end

		local i, j = value:find('^%g+')
		local pluginName = value:sub(i, j)
		local plugin = plugins[pluginName]
		local arguments = value:sub(j + 2)
		if not plugin.commands then plugin.commands = {} end

		if not plugin then return end

		if #arguments == 0 and plugin.blank then
			local result = plugin.blank()
		else
			-- call a :command if given
			local i, j = arguments:find('^:%g+')
			if i ~= nil and j ~= nil then
				local command = arguments:sub(i + 1, j)
				arguments = arguments:sub(j + 2)
				return plugin.commands[command](arguments)
			end

			-- call the plugin with the passed arguments
			plugin.callback(arguments)
		end
	end)
end

local demnuOptions = function()
	local geometry = screen[mouse.screen].geometry
	local screen = 0
	local x = geometry.x + geometry.width / 4
	local y = geometry.height / 3
	local width = geometry.width / 2
	local height = 32
	local font = '"Ubuntu Mono 16"'

	return '' ..
		' -s ' .. screen ..
		' -x ' .. x ..
		' -y ' .. y ..
		' -w ' .. width ..
		' -h ' .. height ..
		' -fn ' .. font
end

omni.menu = function()
	local cmd = 'dmenu_run' .. demnuOptions() .. ' -p "RUN" -l 16'
	return util.run(cmd)
end

omni.prompt = function(prompt, choices, fn)
	if not fn then
		fn = choices
		choices = prompt
		prompt = '>'
	end

	local choice = util.exec('echo -e "' .. table.concat(choices, '\n') .. '"' .. ' | ' .. 'dmenu' .. demnuOptions() .. ' -p "' .. prompt .. '"')
	fn(choice)
end


return omni
