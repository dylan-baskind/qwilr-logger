###
	This is a simple logging utility for Qwilr.
	With a couple of verbs / states.
	Like 'at' for describing where in the codebase we are.
	And 'success' / 'error' / 'note' etc.
	We can use it like normal log: log 'Something'
	Or we can use the log.at "Some Function"
	Loggers also have names.
###
_ = require "lodash"

module.exports = (options) ->

	# Can supply log name as the only argument 
	# aka: require('qwilr-logger')('log-name')
	# OR, as part of the options object.
	# aka: require('qwilr-logger')(debug: yes, name: 'log-name')
	logName =
		if _.isString(options) 
			options + " "
		else if options.name?
			options.name + " "
		else
			""
			
	# Stub out the functions 
	# if we're not in debug mode
	# so that log prints nothing...
	if options?.debug is no
		log = ->
		stubs = ['at', 'doing', 'say', 'success', 'error', 'note']
		for stubFn in stubs
			log[stubFn] = ->
		return log
	
	colors = require('colors/safe')

	log = (args...) ->
		# We can set the logger to silent 
		# with this Node environment flag
		return if process.env.SILENT_LOGGING?

		args.unshift colors.grey(logName)
		console.log.apply( console, args )

	log.warn = (data...) ->		
		log colors.yellow( data )

	log.at = (data...) ->
		console.log ""
		log colors.magenta("-------------------------")
		log colors.magenta("AT: ", data )
		log colors.magenta("-------------------------")

	log.doing = (data...) ->
		log colors.blue( data )

	log.say = (data...) ->
		log data

	log.error = (data...) ->
		log colors.red( "ERROR: ", data )
		log colors.red("------------------------------")

		# If we have Raven installed
		if options.raven?
			# Capture the error + logger name
			options.raven.captureError( options.name + ": " + data )

	log.success = (data...) ->
		log colors.green( data )

	log.note = (data...) ->
		log colors.cyan( data )

	return log

