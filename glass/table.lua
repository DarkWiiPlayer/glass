--- Pseudo-loader for Lua tables
-- Can be used to "overlay" static values over or under other configuration sources.
-- @module glass.table

--- Returns a (pseudo-)loader function from a given Table
-- @tparam table table The table in which to look up valuse
-- @treturn function A loader function to be used with `glass.bind`
return function(input)
	return function(name)
		local result = input[name:match("[^/].+$")]
		if result then
			return true, result
		end
	end
end
