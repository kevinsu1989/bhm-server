
_async = require 'async'
_http = require('bijou').http
_ = require 'lodash'
_entity = require '../entity'
_ip = require 'lib-qqwry'
_common = require '../common'
_redis = require 'redis'

# _entity = require '../entity'

records = []

records_flash = [];

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

exports.receiveFlashLoad = (req, res, cb)-> 
  data = {}
  data.timestamp = new Date().valueOf()
  data.ip = _ip.ipToInt _common.getClientIp(req)
  data.url = req.query.url || null
  data.hash = String(req.query.hash) + String(data.ip)
  data.load_time = req.query.load_time
  data.server_version = server_version

  records_flash.push data 
  if records_flash.length > 0
    _records_flash = records_flash
    records_flash = []
    _entity.records_flash.addRecords _records_flash, (err, result)->
      cb err
  else
    cb null


exports.receiveData = (req, res, cb)->
  data = req.query
  data = _.extend data, {
    ip: _ip.ipToInt _common.getClientIp(req)
    timestamp: new Date().valueOf()
    server_version: server_version
    ua: req.headers['user-agent'].substring(0,100) || null
    snail_name: req.query.snail_name || null
    snail_duration: req.query.snail_duration || null
    flash_js_load: req.query.flash_js_load || null
    flash_js_load_start: req.query.flash_js_load_start || null
    version: req.query.version || null
  }
  data.url = data.url.split('?')[0] if type of data.url is 'string'
  data.snail_name = data.snail_name.split('?')[0] if type of data.snail_name is 'string'
  data.hash = String(req.query.hash) + String(data.ip)
  delete data.callback
  delete data._
  if !validateData(data)
    data.first_paint = 0
    data.dom_ready = 0
    data.load_time = 0
    data.first_view = 0

  records.push data 

  if records.length > 0
    _records = records
    records = []
    _entity.records.addRecords _records, (err, result)->
      cb err
  else
    cb null


exports.insert2DB = (req, res, cb)->
  for key, entity of _entity 
    entity.insert2DB() if entity.insert2DB

