{Parser,DefaultHandler} = require('htmlparser')

# builds template function from given dom AST
build = (dom) ->
	(data) ->
		# TODO traverse dom parsing mustache fragments

# parses template string and returns function that builds virtual DOM
compile = (input) ->
	input = '' unless input
	template = (data) -> ''

	handler = new DefaultHandler (err, dom) ->
		template = build dom
		
	parser = new Parser()
	parser.parseComplete(input)

	template

module.exports = compile
