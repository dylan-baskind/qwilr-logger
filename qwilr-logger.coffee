module.exports = (options) ->

	# Now log prints nothing...
	if options?.debug is no
		return ( -> )

	colors = require('colors/safe')
	log = console.log

	log.at = (data...) ->
		log ""
		log ("AT: " + data).yellow
		log "-------------------------".yellow

	log.doing = (data...) ->
		log colors.blue( data )

	log.say = (data...) ->
		log data

	log.error = (data...) ->
		log ""
		log colors.red("ERROR: " + data)
		log colors.red('------------------------------')

	log.success = (data...) ->
		log colors.green( data )
		log ""

	log.note = (data...) ->
		log colors.cyan( data )

	return log


