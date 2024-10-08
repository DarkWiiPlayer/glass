--- Loader for environment variables
-- @module glass.environment

--- Loads values from environment variables
-- @treturn string The value of the environment variable
return function(name)
	return true, os.getenv(name:match("[^/].+$"))
end
