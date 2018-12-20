###
delay_([time])
get_(url, [data])
post_(url, [data])
###

$.delay_ = (time = 0) ->

  await new Promise (resolve) ->
    setTimeout ->
      resolve()
    , time

  $.info 'delay', "delayed '#{time} ms'"

  $ # return

$.get_ = (url, data) ->
  res = await axios.get url, params: data or {}
  res.data # return

$.post_ = (url, data) ->
  res = await axios.post url, qs.stringify data
  res.data # return