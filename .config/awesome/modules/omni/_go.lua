--
local defaults = require('modules/defaults')
local util = require('modules/util')
--
local omni = require('modules/omni/main')
--


-- TODO: ideally these would be in their own file, preferably JSON
local bookmarks = {
	':open',
	'google.com'
}


local open = function(url)
	local cmd = defaults.web
	if url ~= ':open' then
		cmd = cmd .. ' ' .. url
	end

	if url ~= '' then
		util.run(cmd)
	end
end


omni.register('go', {
	-- opens the given URL in a new tab
	callback = open,

	-- prompts again with a list of bookmarks
	blank = function()
		util.prompt('bookmarks:', bookmarks, open)
	end
})
