$ = require './../index'
{_} = $

describe '$.post_(url, [data])', ->

  it '$.post_()', ->

    type = $.type $.post_
    unless type == 'async function'
      throw new Error "invalid type '#{type}'"