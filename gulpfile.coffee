# Load gulp + plugins + livereload
gulp = require("gulp")
plugins = require("gulp-load-plugins")(camelize: true)
lr = require("tiny-lr")
server = lr()

gulp.task "styles", ->
	gulp
		.src "Source/styles.less"
		.pipe plugins.plumber()
		.pipe plugins.less()
		.pipe plugins.rename( 'styles.css' )
		.pipe plugins.livereload(server)
		.pipe gulp.dest( "" )

gulp.task "reload", ->
	gulp
		.src "index.html"
		.pipe plugins.livereload(server)


# Watch
gulp.task "watch", ->

	# Listen on port 35729
	server.listen 35729, (err) ->
		return console.log(err) if err

		# LESS Files
		gulp.watch "Source/**/**.less", [ "styles" ]

		gulp.watch "index.html", ['reload']


gulp.task "default", ['watch']
