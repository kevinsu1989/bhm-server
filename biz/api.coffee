
_async = require 'async'
_http = require('bijou').http
_ = require 'lodash'
_entity = require '../entity'
_ip = require 'lib-qqwry'

# _entity = require '../entity'

records = []

records_flash = [];

# timestamp = new Date().valueOf()

# 获取客户端IP
getClientIp = (req)-> 
  ipAddress = req.headers['x-forwarded-for'] ||
  req.connection.remoteAddress ||
  req.socket.remoteAddress ||
  req.connection.socket.remoteAddress
  ipAddress.split("ffff:").pop()
    
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
  data.ip = _ip.ipToInt getClientIp(req)
  data.url = req.query.url || null
  data.hash = String(req.query.hash) + String(data.ip)
  data.load_time = req.query.load_time
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
  data.ip = _ip.ipToInt getClientIp(req)
  data.hash = String(req.query.hash) + String(data.ip)
  data.timestamp = new Date().valueOf()
  if !validateData(data)
    data.first_paint = 0
    data.dom_ready = 0
    data.load_time = 0
    data.first_view = 0

  records.push data 

  # if new Date().valueOf() - timestamp > 10000
  if records.length > 0
    # timestamp = new Date().valueOf()
    _records = records
    records = []
    _entity.records.addRecords _records, (err, result)->
      cb err
  else
    cb null


