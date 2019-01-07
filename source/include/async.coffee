###
delay_([time])
get_(url, [data], [option])
post_(url, [data], [option])
###

$.delay_ = (time = 0) ->

  await new Promise (resolve) ->
    setTimeout ->
      resolve()
    , time

  $.info 'delay', "delayed '#{time} ms'"

  $ # return

$.get_ = (url, data = {}, option = {}) ->

  axios = require 'axios'
  
  option.method = 'get'
  option.params = data
  option.url = url
  
  res = await axios option
  res.data # return

$.post_ = (url, data = {}, option = {}) ->

  axios = require 'axios'
  qs = require 'qs'
  
  option.data = qs.stringify data
  option.method = 'post'
  option.url = url
  
  res = await axios option
  res.data # return