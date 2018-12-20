$ = require './../index'
{_} = $

describe '$.each()', ->

  it '$.each()', ->

    unless $.each == _.each
      throw new Error()