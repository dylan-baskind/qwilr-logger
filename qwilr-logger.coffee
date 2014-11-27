###
	This is a simple logging utility for Qwilr.
	With a couple of verbs / states.
	Like 'at' for describing where in the codebase we are.
	And 'success' / 'error' / 'note' etc.
	We can use it like normal log: log 'Something'
	Or we can use the log.at "Some Function"
###

module.exports = (options) ->

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
	log = console.log

	log.at = (data...) ->
		log ""
		log colors.yellow("AT: " + data)
		log colors.yellow("-------------------------")

	log.doing = (data...) ->
		log colors.blue( data )

	log.say = (data...) ->
		log data

	log.error = (data...) ->
		log ""
		log colors.red( "ERROR: " + data )
		log colors.red("------------------------------")

	log.success = (data...) ->
		log colors.green( data )
		log ""

	log.note = (data...) ->
		log colors.cyan( data )

	return log

