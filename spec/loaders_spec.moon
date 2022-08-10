describe 'raw loader', ->
	before_each -> export loader = require 'glass.raw'
	it 'loads files as plain text', ->
		assert.same 'plain text\n', loader 'spec/fixtures/test'

describe 'lua loader', ->
	before_each -> export loader = require 'glass.lua'
	it 'loads Lua files', ->
		assert.same { foo: 'bar', tab: {} }, loader 'spec/fixtures/test'
