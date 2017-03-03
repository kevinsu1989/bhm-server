_async = require 'async'
_http = require('bijou').http
_ = require 'lodash'
_entity = require '../entity'
_ip = require 'lib-qqwry'
_common = require '../common'
_redis = require("../redis-connect").redis

_schema = require '../schema'

server_version = process.env.npm_package_version


# 验证数据
validateData = (data)->
  reg = /^\d+(\.\d+)?$/
  return reg.test(data.first_paint) &&
  reg.test(data.dom_ready) &&
  reg.test(data.load_time) &&
  reg.test(data.first_view) &&
  (data.first_paint * 1 + data.dom_ready * 1 + data.load_time * 1 + data.first_view * 1) < 3600000 &&
  data.first_paint * data.dom_ready * data.load_time * data.first_view > 0


# 基础数据
exports.receiveData = (req, res, cb)->
  ua = _common.parseUA(req)
  data = _common.initInsertData _schema.records.schema.fields, req.query, true
  data.url = data.url.split('?')[0].substring(0,100) if typeof data.url is 'string'
  data.refer = data.refer.split('?')[0].substring(0,100) if typeof data.refer is 'string'
  data.snail_name = data.snail_name.split('?')[0].substring(0,100) if typeof data.snail_name is 'string'
  data.ip = _ip.ipToInt _common.getClientIp(req)
  data = _.extend data,
    timestamp : new Date().valueOf(),
    hash: String(req.query.hash) + String(data.ip)

  if ua.browser.name
    data.browser_name = ua.browser.name.toLowerCase()
  else
    data.browser_name = null
  data.browser_version = ua.browser.version || null
  data.ua = ua.ua.substring(0,100) || null



  if !validateData(data)
    data.first_paint = 0
    data.dom_ready = 0
    data.load_time = 0
    data.first_view = 0

  _redis.lpush "bhm:records", JSON.stringify(data)
    
  cb null, null


# PV上报
exports.receivePV = (req, res, cb)->
  ua = _common.parseUA(req)
  data = _common.initInsertData _schema.records_pv.schema.fields, req.query
  data.url = data.url.split('?')[0].substring(0,100) if typeof data.url is 'string'
  data.ip = _ip.ipToInt _common.getClientIp(req)
  data.cli_time = req.query.hash || 0
  data = _.extend data,
    timestamp : new Date().valueOf(),
    hash: String(req.query.hash) + String(data.ip)

  if ua.browser.name
    data.browser_name = ua.browser.name.toLowerCase()
  else
    data.browser_name = null
  data.browser_version = ua.browser.version || null
  data.ua = ua.ua.substring(0,100) || null


  _redis.lpush "bhm:records:pv", JSON.stringify(data)

  # _redis.lpush "bhm:records:timeline:pv:", JSON.stringify(data)
    
  cb null, null

# JS报错上报
exports.receiveJsError = (req, res, cb)->
  data = _common.initInsertData _schema.records_js_error.schema.fields, req.query
  data.timestamp = new Date().valueOf()
  data.ip = _ip.ipToInt _common.getClientIp(req)
  data.ua = req.headers['user-agent'].substring(0,100) || null
  data.url = data.url.split('?')[0].substring(0,100) if typeof data.url is 'string'
  data.message = data.message.split('?')[0].substring(0,300) if typeof data.message is 'string'


  _redis.lpush "bhm:records:error:js", JSON.stringify(data)
    
  cb null, null


