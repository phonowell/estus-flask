class Logger

  ###
  @cache-muted
  @cache-separator
  @cache-time
  @cache-type
  @reg-base
  @reg-home
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

  '@cache-muted': []
  '@cache-separator': "#{kleur.gray '›'} "
  '@cache-time': []
  '@cache-type': {}
  '@reg-base': new RegExp process.cwd(), 'g'
  '@reg-home': new RegExp (require 'os').homedir(), 'g'

  execute: (arg...) ->

    [type, text] = switch arg.length
      when 1 then ['default', arg[0]]
      when 2 then arg
      else throw new Error 'invalid argument length'

    if @['@cache-muted'].length
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

    unless key or key == 'all'
      throw new Error "invalid key '#{key}'"

    list = @['@cache-muted']

    if key in list
      return @

    list.push key
    
    @ # return

  render: (type, string) ->

    [
      @renderTime()
      @['@cache-separator']
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
    .replace @['@reg-base'], '.'
    .replace @['@reg-home'], '~'

  renderTime: ->

    cache = @['@cache-time']
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

    @['@cache-type'][type] or= do ->

      if type == 'default'
        return ''

      stringContent = kleur.cyan().underline type
      stringPad = _.repeat ' ', 10 - type.length

      "#{stringContent}#{stringPad} " # return

  resume: (key) ->

    if key == 'all'
      @['@cache-muted'] = []
      return @

    list = @['@cache-muted']

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

$.info = (arg...) -> $.info.logger.execute arg...
$.info.logger = new Logger()
$.info.pause = (arg...) -> $.info.logger.pause arg...
$.info.renderPath = (arg...) -> $.info.logger.renderPath arg...
$.info.resume = (arg...) -> $.info.logger.resume arg...

$.log = console.log