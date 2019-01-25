$ = require 'fire-keeper'
{_} = $

# return
module.exports = ->

  {info} = require '../index'
  
  info
  .pause 'a'
  .pause 'b'
  .pause 'c'

  .resume 'a'
  .resume 'b'
  .resume 'd'
  
  info 'debug', '123'