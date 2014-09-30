gulp = require 'gulp'
mocha = require 'gulp-mocha'

gulp.task 'default', ->
	gulp.src('test/*.coffee', {read: false})
	.pipe(mocha({reporter: 'nyan'}))
