$ = require './../index'
{_} = $

describe '$.type(input)', ->

  it '$.trim()', ->

    listQuestion = [
      1024 # number
      'hello world' # string
      true # boolean
      [1, 2, 3] # array
      {a: 1, b: 2} # object
      -> null # function
      -> await new Promise (resolve) -> resolve() # async function
      new Date() # date
      new Error() # error
      Buffer.from 'String' # buffer
      null # null
      undefined # undefined
      NaN # NaN
    ]

    listAnswer = [
      'number'
      'string'
      'boolean'
      'array'
      'object'
      'function'
      'async function'
      'date'
      'error'
      'buffer'
      'null'
      'undefined'
      'number'
    ]

    $.each listQuestion, (question, i) ->
      it "$.type('#{question}')", ->
        unless listAnswer[i] == $.type question
          throw new Error()
