# Load gulp + plugins + livereload
gulp = require("gulp")
plugins = require("gulp-load-plugins")(camelize: true)
lr = require("tiny-lr")
server = lr()

gulp.task "test", ->
	gulp
		.src "qwilr-logger.coffee", read: no
		.pipe plugins.mocha reporter: 'spec'


# gulp.task "publish-patch", ->

# gulp.task 'publish-to-npm', (done) ->
#   spawn('npm', ['publish'], { stdio: 'inherit' }).on('close', done)

gulp.task 'watch', ->
	server.listen 35700, (err) ->
		return console.log(err) if err

		# Watch main file
		gulp.watch 'qwilr-logger.coffee', ["test"]