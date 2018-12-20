###
parseJson(input)
parseString(input)
###

$.parseJson = (input) ->
  switch $.type input
    when 'array' then input
    when 'buffer' then $.parseJSON input
    when 'object' then input
    when 'string' then $.parseJSON input
    else null

$.parseString = (input) ->

  switch $.type input

    when 'array'

      (JSON.stringify __container__: input)
      .replace /{(.*)}/, '$1'
      .replace /"__container__":/, ''

    when 'object' then JSON.stringify input

    when 'string' then input

    else String input