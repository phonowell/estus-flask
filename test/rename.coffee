$ = require './../index'
{_} = $

describe 'rename', ->

  it 'rename', ->

    listKey = [
      'delay'
      'get'
      'post'
    ]
    for key in listKey
      type = $.type $["#{key}_"]
      unless type == 'async function'
        throw new Error "invalid type of '$.#{key}_()': #{type}"
      type = $.type $["#{key}Async"]
      unless type == 'async function'
        throw new Error "invalid type of '$.#{key}Async()': #{type}"