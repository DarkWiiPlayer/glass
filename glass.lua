--- Loads configurations from files on demand.
-- @author DarkWiiPlayer
-- @license Unlicense

local lfs = require 'lfs'

local config = {}

local __metatable = {}
function __metatable:__index(index)
	if type(index)~="string" then
		return nil
	end
	local dot = index:find(".", 1, true)
	if dot then
		return self[index:sub(1, dot-1)][index:sub(dot+1)]
	end
	local path = self.__dir..'/'..index
	local attributes = lfs.attributes(path)
	if attributes and attributes.mode=='directory' then
		return config.bind(path, self.__loaders)
	else
		for _, loader in ipairs(self.__loaders) do
			local result = loader(path)
			if result then
				rawset(self, index, result)
				return result
			end
		end
	end
end

--- Binds a table to a config directory.
-- The returned table maps keys to configurations, which are handled by
-- different "loaders". loaders are handlers that try loading a config entry in
-- a certain format and are tried  sequentially until one succeeds. If no
-- loader matches, nil is returned.
-- @tparam string dir Path to the directory to look in.
-- @tparam table loaders A table of loaders to use when attempting to load a configuration entry.
-- @treturn table config A table that maps to the config directory
-- @usage
-- 	local config = glass.bind 'configurations'
-- 	main_config.foo.bar
-- 	-- Loads some file like foo.json or foo.yaml
-- 	-- in the configurations directory
function config.bind(dir, loaders)
	if type(dir)~="string" then
		error(string.format("bad argument #1 to '%s' (string expected, got %s)", debug.getinfo(1).name, type(loaders)), 2)
	end
	if type(loaders)~="table" then
		error(string.format("bad argument #2 to '%s' (table expected, got %s)", debug.getinfo(1).name, type(loaders)), 2)
	end
	return setmetatable({__dir=dir, __loaders=loaders}, __metatable)
end

return config
