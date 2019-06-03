$ = require './../index'
{_} = $

describe '$.extend()', ->

  it '$.extend()', ->

    unless $.extend == _.extend
      throw new Error()
