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

omni.menu = function()
	local cmd = 'rofi -show run'
	return util.run(cmd)
end

-- TODO: allow easy theming
-- TODO: allow options to be passed
omni.prompt = function(prompt, choices, fn)
	if not fn then
		fn = choices
		choices = prompt
		prompt = '>'
	end

	local choice = util.exec('echo -e "' .. table.concat(choices, '\n') .. '"' .. ' | ' .. 'rofi -dmenu -p "' .. prompt .. '"')
	fn(choice)
end


return omni
