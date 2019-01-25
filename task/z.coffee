$ = require 'fire-keeper'
{_} = $

# return
module.exports = ->

  {info} = require '../index'
  
  info
  .pause 'a'
  .pause 'b'

  info 'debug', '1'

  info
  .resume 'b'
  .resume 'a'
  
  info 'debug', '2'