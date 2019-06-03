$ = require 'fire-keeper'
{_} = $

# return
module.exports = ->

  await $.lint_ [
    './**/*.coffee'
    './**/*.md'
    '!**/node_modules/**'
  ]
