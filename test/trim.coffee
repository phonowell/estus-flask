$ = require './../index'
{_} = $

describe '$.trim()', ->

  it '$.trim()', ->

    unless $.trim == _.trim
      throw new Error()