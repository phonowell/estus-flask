(function() {
  var $, Logger, _, i, key, kleur, len, listKey, logger;

  module.exports = $ = {};

  $._ = _ = require('lodash');

  kleur = require('kleur');

  /*
  delay_([time])
  get_(url, [data], [option])
  post_(url, [data], [option])
  */
  $.delay_ = async function(time = 0) {
    await new Promise(function(resolve) {
      return setTimeout(function() {
        return resolve();
      }, time);
    });
    $.info('delay', `delayed '${time} ms'`);
    return $; // return
  };

  $.get_ = async function(url, data = {}, option = {}) {
    var axios, res;
    axios = require('axios');
    option.method = 'get';
    option.params = data;
    option.url = url;
    res = (await axios(option));
    return res.data; // return
  };

  $.post_ = async function(url, data = {}, option = {}) {
    var axios, qs, res;
    axios = require('axios');
    qs = require('qs');
    option.data = qs.stringify(data);
    option.method = 'post';
    option.url = url;
    res = (await axios(option));
    return res.data; // return
  };

  /*
  each()
  extend()
  noop()
  now()
  param()
  parseJSON(data)
  trim()
  type(arg)
  */
  $.each = _.each;

  $.extend = _.extend;

  $.noop = _.noop;

  $.now = _.now;

  $.param = (require('querystring')).stringify;

  $.parseJSON = JSON.parse;

  $.trim = _.trim;

  $.type = function(input) {
    var type;
    type = Object.prototype.toString.call(input).replace(/^\[object\s(.+)]$/, '$1').toLowerCase();
    if (type === 'asyncfunction') {
      return 'async function';
    }
    if (type === 'uint8array') {
      return 'buffer';
    }
    return type; // return
  };

  /*
  serialize(string)
  timestamp([arg])
  */
  $.serialize = function(string) {
    var a, b, i, key, len, ref, res, value;
    switch ($.type(string)) {
      case 'object':
        return string;
      case 'string':
        if (!~string.search(/=/)) {
          return {};
        }
        res = {};
        ref = _.trim(string.replace(/\?/g, '')).split('&');
        for (i = 0, len = ref.length; i < len; i++) {
          a = ref[i];
          b = a.split('=');
          [key, value] = [_.trim(b[0]), _.trim(b[1])];
          if (key.length) {
            res[key] = value;
          }
        }
        return res;
      default:
        throw new Error('invalid argument type');
    }
  };

  $.timestamp = function(arg) {
    var a, b, date, list, string;
    switch ($.type(arg)) {
      case 'null':
      case 'undefined':
        return _.floor(_.now(), -3);
      case 'number':
        return _.floor(arg, -3);
      case 'string':
        break;
      default:
        throw new Error('invalid argument type');
    }
    string = _.trim(arg).replace(/\s+/g, ' ').replace(/[-|\/]/g, '.');
    date = new Date();
    list = string.split(' ');
    b = list[0].split('.');
    date.setFullYear(b[0], b[1] - 1, b[2]);
    if (!(a = list[1])) {
      date.setHours(0, 0, 0, 0);
    } else {
      a = a.split(':');
      date.setHours(a[0], a[1], a[2] || 0, 0);
    }
    return date.getTime();
  };

  Logger = (function() {
    class Logger {
      /*
      execute(arg...)
      getStringTime()
      pause(key)
      render(type, string)
      renderContent(string)
      renderPath(string)
      renderSeparator()
      renderTime()
      renderType(type)
      resume(key)
      */
      execute(...arg) {
        var message, text, type;
        [type, text] = (function() {
          switch (arg.length) {
            case 1:
              return ['default', arg[0]];
            case 2:
              return arg;
            default:
              throw new Error('invalid argument length');
          }
        })();
        if (this['__token_muted__']) {
          return text;
        }
        message = _.trim($.parseString(text));
        if (!message.length) {
          return text;
        }
        console.log(this.render(type, message));
        return text; // return
      }

      getStringTime() {
        var date, item, listTime;
        date = new Date();
        listTime = [date.getHours(), date.getMinutes(), date.getSeconds()];
        return ((function() {
          var i, len, results;
          results = [];
          for (i = 0, len = listTime.length; i < len; i++) {
            item = listTime[i];
            // return
            results.push(_.padStart(item, 2, 0));
          }
          return results;
        })()).join(':');
      }

      pause(key) {
        var stringToken;
        stringToken = '__token_muted__';
        if (this[stringToken]) {
          return;
        }
        return this[stringToken] = key;
      }

      render(type, string) {
        return [this.renderTime(), this.renderSeparator(), this.renderType(type), this.renderContent(string)].join('');
      }

      renderContent(string) {
        var message;
        // 'xxx'
        message = this.renderPath(string).replace(/'.*?'/g, function(text) {
          var cont;
          cont = text.replace(/'/g, '');
          if (cont.length) {
            return kleur.magenta(cont);
          } else {
            return "''";
          }
        });
        return message; // return
      }

      renderPath(string) {
        return string.replace(this['__reg_base__'], '.').replace(this['__reg_home__'], '~');
      }

      renderSeparator() {
        var cache, stringSeparator;
        cache = this['__cache_separator__'];
        if (cache) {
          return cache;
        }
        stringSeparator = kleur.gray('›');
        // return
        return this['__cache_separator__'] = `${stringSeparator} `;
      }

      renderTime() {
        var cache, stringTime, ts;
        cache = this['__cache_time__'];
        ts = _.floor(_.now(), -3);
        if (ts === cache[0]) {
          return cache[1];
        }
        cache[0] = ts;
        stringTime = kleur.gray(`[${this.getStringTime()}]`);
        // return
        return cache[1] = `${stringTime} `;
      }

      renderType(type) {
        var cache, stringContent, stringPad;
        cache = this['__cache_type__'];
        type = _.trim($.parseString(type));
        type = type.toLowerCase(type);
        if (cache[type]) {
          return cache[type];
        }
        if (type === 'default') {
          return cache[type] = '';
        }
        stringContent = kleur.cyan().underline(type);
        stringPad = _.repeat(' ', 10 - type.length);
        
        // return
        return cache[type] = `${stringContent}${stringPad} `;
      }

      resume(key) {
        var stringToken;
        stringToken = '__token_muted__';
        if (!this[stringToken]) {
          return;
        }
        if (key !== this[stringToken]) {
          return;
        }
        return this[stringToken] = null;
      }

    };

    /*
    __cache_separator__
    __cache_time__
    __cache_type__
    __reg_base__
    __reg_home__
    */
    Logger.prototype.__cache_separator__ = null;

    Logger.prototype.__cache_time__ = [];

    Logger.prototype.__cache_type__ = {};

    Logger.prototype.__reg_base__ = new RegExp(process.cwd(), 'g');

    Logger.prototype.__reg_home__ = new RegExp((require('os')).homedir(), 'g');

    return Logger;

  }).call(this);

  // return
  /*
  $.i(msg)
  $.info(arg...)
  $.log()
  */
  $.i = function(msg) {
    $.log(msg);
    return msg;
  };

  // $.info()
  logger = new Logger();

  $.info = function(...arg) {
    return logger.execute(...arg);
  };

  $.info.pause = function(...arg) {
    return logger.pause(...arg);
  };

  $.info.renderPath = function(...arg) {
    return logger.renderPath(...arg);
  };

  $.info.resume = function(...arg) {
    return logger.resume(...arg);
  };

  $.log = console.log;

  /*
  parseJson(input)
  parseString(input)
  */
  $.parseJson = function(input) {
    switch ($.type(input)) {
      case 'array':
        return input;
      case 'buffer':
        return $.parseJSON(input);
      case 'object':
        return input;
      case 'string':
        return $.parseJSON(input);
      default:
        return null;
    }
  };

  $.parseString = function(input) {
    switch ($.type(input)) {
      case 'array':
        return (JSON.stringify({
          __container__: input
        })).replace(/{(.*)}/, '$1').replace(/"__container__":/, '');
      case 'object':
        return JSON.stringify(input);
      case 'string':
        return input;
      default:
        return String(input);
    }
  };

  listKey = ['delay', 'get', 'post'];

  for (i = 0, len = listKey.length; i < len; i++) {
    key = listKey[i];
    $[`${key}Async`] = $[`${key}_`];
  }

}).call(this);
