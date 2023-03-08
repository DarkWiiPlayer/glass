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
	local raw = read(file..'.yml') or read(file..'.yaml')
	if raw then
		return yaml.load(raw)
	end
end
