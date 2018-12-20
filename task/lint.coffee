$ = require 'fire-keeper'
{_} = $

# return
module.exports = ->
  
  await $.chain $

  .lint_ [
    './*.md'
  ]

  .lint_ [
    './gulpfile.coffee'
    './source/**/*.coffee'
    './task/**/*.coffee'
    './test/**/*.coffee'
  ]