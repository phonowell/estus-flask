class Logger

  ###
  __cache-muted__
  __cache-separator__
  __cache-time__
  __cache-type__
  __reg-base__
  __reg-home__
  execute(arg...)
  getStringTime()
  pause(key)
  render(type, string)
  renderContent(string)
  renderPath(string)
  renderTime()
  renderType(type)
  resume(key)
  ###

  '__cache-muted__': []
  '__cache-separator__': "#{kleur.gray '›'} "
  '__cache-time__': []
  '__cache-type__': {}
  '__reg-base__': new RegExp process.cwd(), 'g'
  '__reg-home__': new RegExp (require 'os').homedir(), 'g'

  execute: (arg...) ->

    [type, text] = switch arg.length
      when 1 then ['default', arg[0]]
      when 2 then arg
      else throw new Error 'invalid argument length'

    if @['__cache-muted__'].length
      return text

    message = _.trim $.parseString text
    unless message.length
      return text

    console.log @render type, message

    text # return

  getStringTime: ->

    date = new Date()
    listTime = [
      date.getHours()
      date.getMinutes()
      date.getSeconds()
    ]

    # return
    (_.padStart item, 2, 0 for item in listTime).join ':'

  pause: (key) ->

    unless key
      throw new Error "invalid key '#{key}'"

    list = @['__cache-muted__']

    if key in list
      return @

    list.push key
    
    @ # return

  render: (type, string) ->

    [
      @renderTime()
      @['__cache-separator__']
      @renderType type
      @renderContent string
    ].join ''

  renderContent: (string) ->

    message = @renderPath string

    # 'xxx'
    .replace /'.*?'/g, (text) ->
      cont = text.replace /'/g, ''
      unless cont.length
        return "''"
      kleur.magenta cont
    
    message # return

  renderPath: (string) ->
  
    string
    .replace @['__reg-base__'], '.'
    .replace @['__reg-home__'], '~'

  renderTime: ->

    cache = @['__cache-time__']
    ts = _.floor _.now(), -3

    if ts == cache[0]
      return cache[1]
    cache[0] = ts

    stringTime = kleur.gray "[#{@getStringTime()}]"

    # return
    cache[1] = "#{stringTime} "

  renderType: (type) ->

    type = _.trim $.parseString type
    .toLowerCase()

    @['__cache-type__'][type] or= do ->

      if type == 'default'
        return ''

      stringContent = kleur.cyan().underline type
      stringPad = _.repeat ' ', 10 - type.length

      "#{stringContent}#{stringPad} " # return

  resume: (key) ->

    list = @['__cache-muted__']

    unless key in list
      throw new Error "invalid key '#{key}'"

    _.remove list, (_key) -> _key == key

    @ # return

# return

###
$.i(msg)
$.info(arg...)
$.log()
###

$.i = (msg) ->
  $.log msg
  msg

# $.info()

logger = new Logger()

$.info = (arg...) -> logger.execute arg...
$.info.pause = (arg...) -> logger.pause arg...
$.info.renderPath = (arg...) -> logger.renderPath arg...
$.info.resume = (arg...) -> logger.resume arg...

$.log = console.log