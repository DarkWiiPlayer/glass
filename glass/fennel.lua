--- Loader for Fennel files
-- @module glass.fennel

local fennel = require "fennel"
local read = require 'glass.raw'

--- Loads and compiles a Fennel file and runs it.
-- Returns the result of running the Fennel file.
-- If running the code immediately is not desired,
-- it has to be returned as a function.
-- @return The result of the Fennel file after running it
-- @function load
return function(file)
	local success, raw = read(file..'.fnl')
	if success then
		return true, fennel.eval(raw)
	end
end
