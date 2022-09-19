# Glass
Makes your configs (almost) see-through.

## About

Glass is a Lua library that makes it easy to lazy-load configuration files into a Lua table at runtime. Its main purpose is to make accessing different configuration files "transparent" to the programmer.

With Glass, you can index a key in an object in a JSON file in a subdirectory as if indexing a nested table.

As a side effect, it also decouples the code from the config format:
your program doesn't need to care whether a specific configuration file is in YAML or JSON format as long as the structure is correct.

## Example
Assume the file `app/config/settings.json` exists in your project directory with the content `{"user":{"name":"User"}}`

```lua
local glass = require 'glass'
local config = glass.bind('app/config', {
   (require 'glass.json');
})
print(config.settings.user.name) -- prints "User"
```

## How it Works
A glass loader is initialised with a list of loaders and will try each of them in order in its `__index` metamethod. The first loader that is able to fetch the wanted configuration will be used.

## Loaders
Glass offers the following loaders out of the box:
* `cosmo` loads cosmo templates
* `discount` loads markdown files\*.
* `environment` loads environment variables.
* `json` loads a JSON file as a Lua table.
* `lua` loads and executes a Lua file.
* `moonhtml` loads a MoonHTML template and returns it as a function.
* `readfile` loads a file as a string.
* `skooma` loads a skooma template and returns it as a function.
* `table` looks up values in a Lua table
* `yaml` loads a YAML file as a Lua table.

\* For easier interoperability with other template loaders, the `discount` loader returns a static function which can be called to return the generated HTML. The markdown file is only parsed the first time.

### Custom Loaders

A glass loader is simply a Lua function that takes as its argument a path to a
file and attempts to load it into a Lua value.

Loaders will typically add an extension to the given file name before checking
whether that file exists and can be loaded.

When a loader cannot find the expected file, it should return `nil` to let glass
continue the loader chain. When a loader returns a truthy value, this will be
used and no further loaders will be tried.
