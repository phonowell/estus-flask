$ = require './../index'
{_} = $

describe '$.info([method], [type], msg)', ->

  it "$.info('test message')", ->

    string = 'test message'

    res = $.info 'test', string
    unless res == string
      throw new Error()