eof = null # TODO consider to use undefined as eof

class Reader
	constructor: (@input) ->
		@pos = -1

	read: () ->
		@pos++
		if @pos < @input.length then @input.charAt(@pos) else eof

	peek: (inc = 1) ->
		if @pos + inc < @input.length then @input.charAt(@pos + inc) else eof

module.exports = Reader
