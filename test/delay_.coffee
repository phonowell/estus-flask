$ = require './../index'
{_} = $

describe '$.delay_([time])', ->

  it '$.delay_(1e3)', ->

    st = _.now()

    res = await $.delay_ 1e3
    unless res == $
      throw new Error()

    ct = _.now()

    unless 900 < ct - st < 1100
      throw new Error()
