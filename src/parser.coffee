{parse,text,lang} = require('bennu')

# import parsec combinators
space = text.space
oneOf = text.oneOf
letter = text.letter
digit = text.digit
char = text.character

many = parse.many
choice = parse.choice

between = lang.between

# tokens
ws = many(space)
name = many(choice(letter, oneOf('-'), digit))
# TODO support xmlnamespaces
qname = name 
tag = parse.next(char('<'), qname)

# TODO comments, attrs, and so on

prog = between(ws, parse.eof, tag)

module.exports = (input) ->
	parse.run(prog, input)
