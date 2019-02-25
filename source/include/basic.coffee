###
each()
extend()
noop()
now()
param()
parseJSON(data)
trim()
type(arg)
###

$.each = _.each

$.extend = _.extend

$.noop = _.noop

$.now = _.now

$.param = (require 'querystring').stringify

$.parseJSON = JSON.parse

$.trim = _.trim

$.type = (input) ->

  type = Object::toString.call input
  .replace /^\[object\s(.+)]$/, '$1'
  .toLowerCase()

  if type == 'asyncfunction'
    return 'async function'
  
  if type == 'uint8array'
    return 'buffer'

  type # return