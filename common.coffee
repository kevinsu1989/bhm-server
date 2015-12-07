###
  工具类
###
_path = require 'path'
_crypto = require 'crypto'
_events = require 'events'
_ = require 'lodash'


_ua = require 'ua-parser-js'
_util = require 'util'
_pageEvent = new _events.EventEmitter()

#触发事件
exports.trigger = (name, arg...)-> _pageEvent.emit(name, arg)

#监听事件
exports.addListener = (event, listener)-> _pageEvent.addListener event, listener

exports.removeListener = (event, listener)-> _pageEvent.removeListener event, listener

#获取一个正确的路径，允许相对或者绝对路径
exports.storagePath = (key)->
  relativePath = _path.join _config.storage.base, _config.storage[key]
  _path.join __dirname, _path.relative(__dirname, relativePath)


exports.log = (log, type)->
  return if not ENVISDEV
  console.log log

#获取程序的主目录
exports.rootPath = _path.dirname(require.main.filename)

exports.md5 = (text)->
  md5 = _crypto.createHash('md5')
  md5.update(text)
  md5.digest('hex')

#移除扩展名
exports.removeExt = (filename)-> filename.replace /\.\w+/, ''

#过滤掉着头尾的空格
exports.trim = (text)->
  text = text.replace(/^\s*(.+?)\s*$/, "$1") unless text
  text


exports.formatString = (text, args...)->
  return text if not text
  #如果第一个参数是数组，则直接使用这个数组
  args = args[0] if args.length is 1 and args[0] instanceof Array
  text.replace /\{(\d+)\}/g, (m, i) -> args[i]


#清除对象中的undefined
exports.cleanUndefined = (hash)->
  (delete hash[key] if value is undefined) for key, value of hash
  hash

#移掉html中的标签
exports.html2text = (html)->
  return html if not html
  html.replace(/<br\s?\/?>/ig, '\n')
    .replace(/&nbsp;/ig, ' ')
    .replace(/<\/?[^>]*>/g, '')
    .replace(/[ | ]* /g, ' ')
    .replace(RegExp(' ', 'gi'), '')
#    .replace(/ [\s| | ]* /g,' ')


#安全转换JSON
exports.parseJSON = (text)->
  return {} if not text or typeof(text) isnt 'string'
  JSON.parse text

exports.parseUA = (req)->
  _ua req.headers['user-agent']

#过滤入库数据格式
exports.initInsertData = (schema, query)->
  data = {}
  for key, value of schema
    data[key] = query[key] || null
  data


exports.getClientIp = (req)-> 
  ipAddress = req.headers['x-forwarded-for'] ||
  req.connection.remoteAddress ||
  req.socket.remoteAddress ||
  req.connection.socket.remoteAddress
  ipAddress = if /((?:(?:25[0-5]|2[0-4]\d|((1\d{2})|([1-9]?\d)))\.){3}(?:25[0-5]|2[0-4]\d|((1\d{2})|([1-9]?\d))))/.test ipAddress then RegExp.$1 else '127.0.0.1'


