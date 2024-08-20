describe 'fennel loader', ->
	before_each -> export loader = require 'glass.fennel'
	it 'loads Fennel files', ->
		success, result = loader 'spec/fixtures/test'
		assert.true success
		assert.same { foo: 'bar', tab: {} }, result
