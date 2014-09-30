parse = require '../src/parser'

describe 'parser', ->
	it 'should parse simple html', ->
		ast = parse '<html/>'
		console.log(JSON.stringify(ast))
