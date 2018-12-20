$ = require './../index'
{_} = $

describe '$.now()', ->

  it '$.now()', ->

    unless $.now == _.now
      throw new Error()