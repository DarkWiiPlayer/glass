--- Loader for YAML-Data using Lua-CYAML
-- @module glass.yaml

local yaml = require 'lyaml'
local read = require 'glass.raw'

--- Loads a YAML-File and returns a corresponding Lua table.
-- May return non-table values for invalid YAML,
-- as CYAML supports other types than Object at
-- the top-level of the YAML file.
-- @treturn table YAML-Data
-- @function load
return function(file)
	local success, raw = read(file..'.yml')
	if not success then
		success, raw = read(file..'.yaml')
	end
	if success then
		return true, yaml.load(raw)
	end
end
