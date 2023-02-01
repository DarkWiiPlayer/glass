--- Loader for CSV-Data using streamcsv
-- @module glass.csv

local csv = require 'streamcsv'

--- Loads a CSV-File and returns a corresponding Lua table.
-- CSV file is assumed to have a header row.
-- @treturn table CSV-Data
-- @function load
return function(file)
	local file = io.open(file..'.csv')
	if file then
		return csv.file(file)
	end
end
