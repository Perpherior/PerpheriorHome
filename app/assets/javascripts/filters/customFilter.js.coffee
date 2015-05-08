angular.module('CustomFilter', [])
  .filter 'capitalize', ->
    (input, all) ->
      if ! !input then input.replace(/([^\W_]+[^\s-]*) */g, ((txt) ->
        txt.charAt(0).toUpperCase() + txt.substr(1).toLowerCase()
      ))
      else ''

  .filter 'truncate', ->
    (value, wordwise, max, tail) ->
      if !value
        return ''
      max = parseInt(max, 10)
      if !max
        return value
      if value.length <= max
        return value
      value = value.substr(0, max)
      if wordwise
        lastspace = value.lastIndexOf(' ')
        if lastspace != -1
          value = value.substr(0, lastspace)
      value + (tail or ' …')
