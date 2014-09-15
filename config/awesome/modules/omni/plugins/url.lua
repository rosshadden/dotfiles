--
local defaults = require('modules/defaults')
local util = require('modules/util')
--
local omni = require('modules/omni/main')
--


-- TODO: ideally these would be in their own file, preferably JSON
local bookmarks = {
	'google.com'
}


local openURL = function(url)
	local cmd = defaults.web .. ' ' .. url

	if url ~= '' then
		util.run(cmd)
	end
end


omni.register('url', {
	alias = {'web', 'bookmarks'},

	-- opens the given URL in a new tab
	callback = openURL,

	-- prompts again with a list of bookmarks
	blank = function()
		omni.prompt('bookmarks:', bookmarks, openURL)
	end,

	commands = {
		open = function()
			util.run(defaults.web)
		end,

		test = function()
			log('TEST')
		end
	}
})
