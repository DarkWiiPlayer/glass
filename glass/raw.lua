--- Loader for plain files
-- @module glass.readfile

--- Loads a normal file as a string.
-- @treturn string The content of the file
-- @function load
return function(path)
	local f = io.open(path)
	if not f then
		return false
	end
	local result = f:read("*a")
	f:close()
	return true, result
end
