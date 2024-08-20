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
   (require 'glass.error'); -- Throw error if nothing matches
})
print(config.settings.user.name) -- prints "User"
```

## How it Works
A glass loader is initialised with a list of loaders and will try each of them in order in its `__index` metamethod. The first loader that is able to fetch the wanted configuration will be used.

## Loaders
Glass offers the following loaders out of the box:
* `cosmo` loads cosmo templates
* `csv` loads csv files (with header line)
* `discount` loads markdown files\*.
* `environment` loads environment variables.
* `fennel` loads and executes fennel files.
* `json` loads a JSON file as a Lua table. (requires `cjson`)
* `lua` loads and executes a Lua file.
* `moonhtml` loads a MoonHTML template and returns it as a function.
* `readfile` loads a file as a string.
* `skooma.html` loads a `.html.skooma` template and returns it as a function.
* `skooma.xml` same as above for `.xml.skooma`.
* `table` looks up values in a Lua table
* `yaml` loads a YAML file as a Lua table. (requires `lyaml`)
* `error` pseudo-loader that throws an error.

\* For easier interoperability with other template loaders, the `discount` loader returns a static function which can be called to return the generated HTML. The markdown file is only parsed the first time.

Note that some of these loaders require additional dependencies that are not included with glass to keep the installation small.

### Custom Loaders

A glass loader is simply a Lua function that takes as its argument a path to a
file and attempts to load it into a Lua value.

Loaders will typically add an extension to the given file name before checking
whether that file exists and can be loaded.

A successful loader should return `true` followed by its result.
When a loader can't load a key, it should return `false` and an optional
description of why.
When a loader encounters an error (file found but can't be parsed), it should
error.
