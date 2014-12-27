# Load gulp + plugins + livereload
gulp = require("gulp")
plugins = require("gulp-load-plugins")(camelize: true)

gulp.task "build", ->
	gulp
		.src "qwilr-logger.coffee"
		.pipe plugins.coffee({ bare: true })
		.pipe gulp.dest ""
