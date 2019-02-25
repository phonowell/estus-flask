###
serialize(string)
timestamp([arg])
###

$.serialize = (string) ->

  type = $.type string

  unless type in ['object', 'string']
    throw new Error "invalid type '#{type}'"

  if type == 'object'
    return string

  # string

  unless ~string.search /=/
    return {}
  
  res = {}
  for a in _.trim(string.replace /\?/g, '').split '&'
    b = a.split '='
    [key, value] = [
      _.trim b[0]
      _.trim b[1]
    ]
    if key.length
      res[key] = value
  
  res # return

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