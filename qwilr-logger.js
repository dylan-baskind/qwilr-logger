
/*
	This is a simple logging utility for Qwilr.
	With a couple of verbs / states.
	Like 'at' for describing where in the codebase we are.
	And 'success' / 'error' / 'note' etc.
	We can use it like normal log: log 'Something'
	Or we can use the log.at "Some Function"
	Loggers also have names.
 */
var _,
  __slice = [].slice;

_ = require("lodash");

module.exports = function(options) {
  var colors, log, logName, stubFn, stubs, _i, _len;
  logName = _.isString(options) ? options + " " : options.name != null ? options.name + " " : "";
  if (options.debug == null) {
    options.debug = true;
  }
  if ((options != null ? options.debug : void 0) === false) {
    log = function() {};
    stubs = ['at', 'doing', 'say', 'success', 'error', 'note'];
    for (_i = 0, _len = stubs.length; _i < _len; _i++) {
      stubFn = stubs[_i];
      log[stubFn] = function() {};
    }
    return log;
  }
  colors = require('colors/safe');
  log = function() {
    var args;
    args = 1 <= arguments.length ? __slice.call(arguments, 0) : [];
    if (process.env.SILENT_LOGGING != null) {
      return;
    }
    args.unshift(colors.grey(logName));
    return console.log.apply(console, args);
  };
  log.warn = function() {
    var data;
    data = 1 <= arguments.length ? __slice.call(arguments, 0) : [];
    return log(colors.yellow(data));
  };
  log.at = function(data) {
    var border;
    if (process.env.SILENT_LOGGING != null) {
      return;
    }
    console.log("");
    border = Array(data.length + 7).join('-');
    log(colors.magenta(border));
    log(colors.magenta("AT: ", data));
    return log(colors.magenta(border));
  };
  log.doing = function() {
    var data;
    data = 1 <= arguments.length ? __slice.call(arguments, 0) : [];
    return log(colors.blue(data));
  };
  log.say = function() {
    var data;
    data = 1 <= arguments.length ? __slice.call(arguments, 0) : [];
    return log(data);
  };
  log.error = function() {
    var data;
    data = 1 <= arguments.length ? __slice.call(arguments, 0) : [];
    log(colors.red("ERROR: ", data));
    log(colors.red("------------------------------"));
    if (options.errorHandler != null) {
      return options.errorHandler(options.name + ": " + data);
    }
  };
  log.success = function() {
    var data;
    data = 1 <= arguments.length ? __slice.call(arguments, 0) : [];
    return log(colors.green(data));
  };
  log.note = function() {
    var data;
    data = 1 <= arguments.length ? __slice.call(arguments, 0) : [];
    return log(colors.cyan(data));
  };
  return log;
};
