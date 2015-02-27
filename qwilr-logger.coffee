###
	This is a simple logging utility for Qwilr.
	With a couple of verbs / states.
	Like 'at' for describing where in the codebase we are.
	And 'success' / 'error' / 'note' etc.
	We can use it like normal log: log 'Something'
	Or we can use the log.at "Some Function"
	Loggers also have names.
###

_      = require "lodash"
colors = require 'colors/safe'
module.exports = (options) ->

	# Can supply log name as the only argument
	# aka: require('qwilr-logger')('log-name')
	# OR, as part of the options object.
	# aka: require('qwilr-logger')(debug: yes, name: 'log-name')
	# OR, as a function
	# aka: require('qwilr-logger')(name: () -> 'log-name')
	logName =
		if _.isString(options)
			() -> options + " "
		else if options.name? and _.isFunction options.name
			options.name
		else if options.name?
			() -> options.name + " "
		else
			() -> ""

	# We'll default to debug mode
	debug = options.debug || yes

	# Stub out the functions
	# if we're not in debug mode
	# so that log prints nothing...
	if debug is no
		log = ->
		stubs = ['at', 'warn', 'doing', 'say', 'success', 'error', 'note']
		for stubFn in stubs
			log[stubFn] = ->
		return log

	# onLog is called when outputting the log message, it is passed the name
	if options.onLog? and _.isFunction options.onLog
		onLog = options.onLog
	else
		onLog = (verb, name, args...) ->


	log = (args...) ->
		logBase 'info', args


	logBase = (verb, args...) ->
		# We can set the logger to silent
		# with this Node environment flag
		return if process.env.SILENT_LOGGING?
		name = logName()

		args.unshift colors.grey(name)
		console.log.apply( console, args )
		onLog verb, name, args

	log.warn = (data...) ->
		logBase 'warn', colors.yellow( data )

	log.at = (data) ->
		# Space gets output without silent logging.
		return if process.env.SILENT_LOGGING?
		console.log ""

		# NOTE: 7 = "AT: " + a little extra space
		border = Array(data.length + 7).join '-'
		logBase 'at', colors.magenta(border)
		logBase 'at', colors.magenta("AT: ", data )
		logBase 'at', colors.magenta(border)

	log.doing = (data...) ->
		logBase 'doing', colors.blue( data )

	log.say = (data...) ->
		logBase 'say', data

	log.error = (data...) ->
		logBase 'error', colors.red( "ERROR: ", data )
		logBase 'error', colors.red("------------------------------")

		# If we have an error handler function supplied.
		if options.errorHandler?
			# Run error handler fn w/ the error + logger name
			options.errorHandler( logName() + ": " + data )

	log.success = (data...) ->
		logBase 'success', colors.green( data )

	log.note = (data...) ->
		logBase 'note', colors.cyan( data )

	return log

