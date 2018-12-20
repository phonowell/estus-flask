$ = require './../index'
{_} = $

describe '$.get_(url, [data])', ->

  it '$.get_()', ->

    type = $.type $.get_
    unless type == 'async function'
      throw new Error "invalid type '#{type}'"

  it "$.get_('https://app.anitama.net/web')", ->

    data = await $.get_ 'https://app.anitama.net/web'
    type = $.type data
    unless type == 'object'
      throw new Error()

    unless data.success == true
      throw new Error()