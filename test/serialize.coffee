$ = require './../index'
{_} = $

describe '$.serialize(string)', ->

  it "$.serialize('?a=1&b=2&c=3&d=4')", ->

    question = '?a=1&b=2&c=3&d=4'
    answer =
      a: '1'
      b: '2'
      c: '3'
      d: '4'

    unless _.isEqual answer, $.serialize question
      throw new Error()