--- Loader for Skooma templates
-- @module glass.skooma

local html = require('skooma.env')('html')
local env = setmetatable({}, {__index = function(_, key)
	if _G[key] ~= nil then
		return _G[key]
	else
		return html[key]
	end
end})

--- Loads a Lua file with the Skooma environment and runs it.
-- Normally, the file should return a function
-- to follow restia template semantics.
-- @return The result of the template file.
-- @function load
return function(name)
	name = tostring(name)..'.html.skooma'
	local template, err = loadfile(name, "t", env)
	if template == nil then
		return nil, err
	end
	if setfenv then
		setfenv(template, env)
	end
	return true, template
end
