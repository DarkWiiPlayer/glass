--- Loader for Skooma templates
-- @module glass.skooma

local xml = require('skooma.env')('xml')
local env = setmetatable({}, {__index = function(_, key)
	if _G[key] ~= nil then
		return _G[key]
	else
		return xml[key]
	end
end})

--- Loads a Lua file with the Skooma environment and runs it.
-- Normally, the file should return a function
-- to follow restia template semantics.
-- @return The result of the template file.
-- @function load
return function(name)
	name = tostring(name)..'.xml.skooma'
	local template = loadfile(name, "t", env)
	if setfenv then
		setfenv(template, env)
	end
	return template
end
