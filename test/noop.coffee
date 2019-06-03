$ = require './../index'
{_} = $

describe '$.noop()', ->

  it '$.noop()', ->

    unless $.noop == _.noop
      throw new Error()
