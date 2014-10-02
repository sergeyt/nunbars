EOF = 0
SPACE = 1
TEXT = 2
TAG_START = 3 # <tag [attrs]/>
TAG_END = 4 # </tag>
BLOCK_START = 7 # {{#block expression}}
BLOCK_END = 8 # {{/block}}
EXPR = 9 # {{expr}}

# matcher returns next matcher or eof (end of match)
eof = undefined

next = (test, tail) ->
	(c) ->
		if test(c) then tail else eof

many = (test) ->
	(c) ->
		if test(c) then many(test) else eof

# returns next matcher if given char, otherwise eof
char = (value, tail) ->
	test = (c) -> c == value
	next test, tail

anychar = (value, tail) ->
	test = (c) -> value.indexOf(c) >= 0
	next test, tail

refun = (re) ->
	(c) ->
		re.test(c)

rexpr = (re, tail) ->
	test = refun re
	next test, tail

space = many refun /^\s$/g

chain = (tests) ->
	i = 0
	cur = null
	rec = null

	adv = () ->
		if i + 1 < tests.length
			i++
			rec
		else
			eof

	step = (c) ->
		it = tests[i++]
		if typeof it == "function"
			cur = it(c)
			return cur
		if typeof it == "string"
			if c == it then adv() else eof
		if it.test(c) then adv() else eof

	rec = (c) ->
		if typeof(cur) == "function"
			cur = cur(c)
			if cur == eof and i + 1 < tests.length
				i++
				return rec
		if i + 1 < tests.length then step(c) else eof
	rec

nameStart = /^\w|[_-]$/g
nameChar = /^\w|\d|[_-]$/g
qnameSep = (c) -> c == ':'
name = chain [nameStart, nameChar]
qname = chain [name, next(qnameSe, name)]

tokenizers = [
	{
		type: SPACE
		matcher: space
	},
	{
		type: TAG_START
		matcher: chain ['<', qname]
	},
	{
		type: TAG_START
		matcher: chain ['<', qname]
	},
	{
		type: TAG_END
		matcher: chain ['<', '/', qname, '>']
	}
]

class Lexer
	constructor: (@reader) ->
		@current = @reader.read()

	next: () ->


module.exports =
	Lexer: Lexer
	# token types
	TAG_START: TAG_START
	TAG_END: TAG_END
	BLOCK_START: BLOCK_START
	BLOCK_END: BLOCK_END
