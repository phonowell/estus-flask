$ = require './../index'
{_} = $

describe '$.parseJson()', ->

  it '$.parseJson()', ->
    res = $.parseJson()
    if res
      throw new Error()

  it "$.parseJson(Buffer.from('{message: 'a test line'}'))", ->

    string = 'a test line'
    object = message: string
    buffer = Buffer.from $.parseString object

    res = $.parseJson buffer
    unless res.message == 'a test line'
      throw new Error()

describe '$.parseJSON()', ->

  it '$.parseJSON()', ->
    unless $.parseJSON == JSON.parse
      throw new Error()
