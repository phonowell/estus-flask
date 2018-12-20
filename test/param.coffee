$ = require './../index'
{_} = $

describe '$.param()', ->

  it '$.param()', ->

    unless $.param == (require 'querystring').stringify
      throw new Error()