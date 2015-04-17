window._log = ->
  _log.history = _log.history or []
  _log.history.push arguments
  arguments.callee = arguments.callee.caller
  console.log Array::slice.call(arguments)