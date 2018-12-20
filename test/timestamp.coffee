$ = require './../index'
{_} = $

describe '$.timestamp([arg])', ->

  it '$.timestamp()', ->

    timestamp = _.floor $.now(), -3
    result = $.timestamp()

    unless result == timestamp
      throw new Error()

  it '$.timestamp(1502777554000)', ->

    timestamp = 1502777554000
    result = $.timestamp timestamp
    timestamp = _.floor timestamp, -3

    unless result == timestamp
      throw new Error()

  ###
  ###
  listQuestion = [
    [2012, 12, 21]
    [1997, 7, 1]
    [1970, 1, 1]
  ]

  _.each listQuestion, (question) ->

    stringDate = question.join '.'
    result = $.timestamp stringDate

    date = new Date()
    date.setFullYear question[0], question[1] - 1, question[2]
    date.setHours 0, 0, 0, 0
    timestamp = _.floor date.getTime(), -3

    it "$.timestamp('#{stringDate}')", ->

      unless result == timestamp
        throw new Error()

  ###
  ###
  listQuestion = [
    [2012, 12, 21, 12, 21]
    [1997, 7, 1, 19, 30]
    [1970, 1, 1, 8, 1]
  ]

  _.each listQuestion, (question, i) ->

    stringDate = "#{question[0...3].join '.'}
    #{question[3...].join ':'}"
    result = $.timestamp stringDate

    date = new Date()
    date.setFullYear question[0], question[1] - 1, question[2]
    date.setHours question[3], question[4], 0, 0
    timestamp = _.floor date.getTime(), -3

    it "$.timestamp('#{stringDate}')", ->

      unless result == timestamp
        throw new Error()