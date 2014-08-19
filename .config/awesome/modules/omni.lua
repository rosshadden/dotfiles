--
local defaults = require("modules/defaults")
local _ = require("modules/_")
local util = require("modules/util")
--


local omni = {}


local plugins = {}
omni.register = function(namespace, plugin)
	plugins[namespace] = plugin
end

omni.open = function()
	local keys = _.map(_.keys(plugins), function(key)
		return key --.. ':'
	end)

	util.prompt(keys, function(value)
		if #value == 0 then return end

		local i, j = value:find("^%g+")
		local pluginName = value:sub(i, j)
		local plugin = plugins[pluginName]
		local arguments = value:sub(j + 2)

		if not plugin then return end

		if #arguments == 0 then
			plugin.blank()
		else
			plugin.callback(arguments)
		end
	end)
end


-- Plugins
	-- web browser
	omni.register("go", {
		blank = function()
			util.runOrRaise(defaults.web, { class = "Chrome" })
		end,

		callback = function(url)
			util.run(defaults.web .. " " .. url)
		end
	})


return omni
