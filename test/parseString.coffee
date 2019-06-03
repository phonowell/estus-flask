$ = require './../index'
{_} = $

describe '$.parseString(data)', ->

  listQuestion = [
    1024 # number
    'hello world' # string
    true # boolean
    [1, 2, 3] # array
    {a: 1, b: 2} # object
    -> null # function
    new Date() # date
    new Error 'All Right' # error
    Buffer.from 'String' # buffer
    null # null
    undefined # undefined
    NaN # NaN
  ]

  listAnswer = [
    '1024'
    'hello world'
    'true'
    '[1,2,3]'
    '{"a":1,"b":2}'
    listQuestion[5].toString()
    listQuestion[6].toString()
    listQuestion[7].toString()
    listQuestion[8].toString()
    'null'
    'undefined'
    'NaN'
  ]

  _.each listQuestion, (question, i) ->

    it "$.parseString(#{question})", ->

      res = $.parseString question
      unless res == listAnswer[i]
        throw new Error()
