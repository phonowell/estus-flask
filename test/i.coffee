$ = require './../index'
{_} = $

describe '$.i(msg)', ->

  it "$.i('test message')", ->

    string = 'test message'

    res = $.i string
    unless res == string
      throw new Error()
