describe 'raw loader', ->
	before_each -> export loader = require 'glass.raw'
	it 'loads files as plain text', ->
		assert.same {true, 'plain text\n'}, {loader 'spec/fixtures/test'}

describe 'lua loader', ->
	before_each -> export loader = require 'glass.lua'
	it 'loads Lua files', ->
		success, result = loader 'spec/fixtures/test'
		assert.true success
		assert.same { foo: 'bar', tab: {} }, result
