import bind from require 'glass'

describe 'core module', ->
	before_each -> export config = bind 'spec/fixtures', { (require 'glass.lua') }

	it 'loads configurations', ->
		assert.equal "bar", config.test.foo
	
	it 'loads configurations only once', ->
		assert.equal config.test.tab, config.test.tab

	it 'loads configurations anew after deleting them', ->
		old = config.test.tab
		config.test = nil
		assert.not.equal old, config.test.tab
	
	it 'exposes the loader list', ->
		assert.same { (require 'glass.lua') }, config.__loaders
	
	it 'tries configurations in order', ->
		txt_first = bind 'spec/fixtures', { (require 'glass.raw'), (require 'glass.lua') }
		lua_first = bind 'spec/fixtures', { (require 'glass.lua'), (require 'glass.raw') }

		assert.is.table lua_first.test
		assert.is.string txt_first.test
	
	it 'recursively binds to subdirectories', ->
		assert.equal 'file in subdirectory', config.sub.test

	it 'returns nil for missing configs', ->
		assert.nil config.missing
