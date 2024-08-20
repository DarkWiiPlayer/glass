--- Loader for cosmo templates.
-- @module glass.cosmo

local cosmo = require 'cosmo'
local raw = require 'glass.raw'

--- Loads a cosmo template from a file and returns the compiled template.
-- Returns nil if no template can be found.
-- @treturn function Template
-- @function load
return function(name)
	name = tostring(name) .. '.cosmo'
	local text = raw(name)
	if text then
		return true, assert(cosmo.compile(text, name))
	end
end
