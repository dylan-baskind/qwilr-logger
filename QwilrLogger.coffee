module.exports = (options) ->

	# Now log prints nothing...
	if options?.debug is no
		return ( -> )

	color = require('cli-color')
	log = console.log

	log.at = (data...) ->
		route = color.yellow
		log ""
		log route("AT: " + data)
		log route "-------------------------"

	log.doing = (data...) ->
		doing = color.blueBright
		log doing(data)

	log.say = (data...) ->
		say = color.xterm(15)
		log data

	log.error = (data...) ->
		error = color.red.bold
		log ""
		log "ERROR: ", error(data)
		log '------------------------------'

	log.success = (data...) ->
		success = color.green.bold
		log success(data)
		log ""

	log.note = (data...) ->
		note = color.cyan
		log note(data)

	return log


