$ = require './../index'
{_} = $

describe '$.log()', ->

  it '$.log()', ->

    unless $.log == console.log
      throw new Error()