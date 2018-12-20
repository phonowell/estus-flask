###
serialize(string)
timestamp([arg])
###

$.serialize = (string) ->
  switch $.type string
    when 'object' then string
    when 'string'
      if !~string.search /=/ then return {}
      res = {}
      for a in _.trim(string.replace /\?/g, '').split '&'
        b = a.split '='
        [key, value] = [
          _.trim b[0]
          _.trim b[1]
        ]
        if key.length then res[key] = value
      res
    else throw new Error 'invalid argument type'

$.timestamp = (arg) ->

  switch $.type arg
    when 'null', 'undefined' then return _.floor _.now(), -3
    when 'number' then return _.floor arg, -3
    when 'string' then break
    else throw new Error 'invalid argument type'

  string = _.trim arg
  .replace /\s+/g, ' '
  .replace /[-|/]/g, '.'

  date = new Date()

  list = string.split ' '

  b = list[0].split '.'
  date.setFullYear b[0], (b[1] - 1), b[2]

  if !(a = list[1])
    date.setHours 0, 0, 0, 0
  else
    a = a.split ':'
    date.setHours a[0], a[1], a[2] or 0, 0

  date.getTime()