
_async = require 'async'
_http = require('bijou').http
_ = require 'lodash'
_entity = require '../entity'
_ip = require 'lib-qqwry'
_common = require '../common'
_redis = require 'redis'
_ = require 'lodash'

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

getFlashData = (req)->
  data = 
    timestamp: new Date().valueOf(),
    url: req.query.url || null,
    video_id: req.query.video_id || null,
    cli_version: req.query.cli_version || null,
    cli_time: req.query.cli_time || 0,
    ip: _ip.ipToInt _common.getClientIp(req)

  data.hash = String(req.query.hash) + String(data.ip)
  data.url = data.url.split('?')[0].substring(0,100) if typeof data.url is 'string'

  data

# flash加载成功上报
exports.receiveFlashLoad = (req, res, cb)-> 
  data = getFlashData(req)

  data.load_time = req.query.load_time || 0

  _entity.records_flash.addRecords data, (err, result)->
    cb err

# flash广告播放上报
exports.receiveFlashAd = (req, res, cb)-> 
  data = getFlashData(req)

  data.ad_time = req.query.ad_time || 0

  _entity.records_flash_ad.addRecords data, (err, result)->
    cb err

# flash广告播放完成上报
exports.receiveFlashAdEnd = (req, res, cb)-> 
  data = getFlashData(req)

  data.ad_time = req.query.ad_time || 0

  _entity.records_flash_ad_end.addRecords data, (err, result)->
    cb err

# 播放器正片播放
exports.receiveFlashPlay = (req, res, cb)-> 
  data = getFlashData(req)
  
  data.ad_time = req.query.ad_time || 0

  _entity.records_flash_play.addRecords data, (err, result)->
    cb err

# CMS上报
exports.receiveFlashCMS = (req, res, cb)-> 
  data = getFlashData(req)

  _entity.records_flash_cms.addRecords data, (err, result)->
    cb err

# 调度上报 
exports.receiveFlashDispatch = (req, res, cb)-> 
  data = getFlashData(req)

  _entity.records_flash_dispatch.addRecords data, (err, result)->
    cb err

# 正片加载成功
exports.receiveFlashVideoLoad = (req, res, cb)-> 
  data = getFlashData(req)

  _entity.records_flash_video_load.addRecords data, (err, result)->
    cb err

# 视频缓冲满
exports.receiveFlashBufferFull = (req, res, cb)-> 
  data = getFlashData(req)

  _entity.records_flash_buffer_full.addRecords data, (err, result)->
    cb err

# 基础数据
exports.receiveData = (req, res, cb)->
  ua = _common.parseUA(req)
  data = _common.initInsertData _schema.records.schema.fields, req.query
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

  _entity.records.addRecords data, (err, result)->
    cb err


# PV上报
exports.receivePV = (req, res, cb)-> 
  ua = _common.parseUA(req)
  data = _common.initInsertData _schema.records_pv.schema.fields, req.query
  data.url = data.url.split('?')[0].substring(0,100) if typeof data.url is 'string'
  data.ip = _ip.ipToInt _common.getClientIp(req)
  data.cli_time = req.query.hash || 0
  data = _.extend data,
    # browser_name: ua.browser.name, 
    # browser_version: ua.browser.version,
    # ua: ua.ua.substring(0,100),
    timestamp : new Date().valueOf(),
    hash: String(req.query.hash) + String(data.ip)


  if ua.browser.name
    data.browser_name = ua.browser.name.toLowerCase()
  else
    data.browser_name = null
  data.browser_version = ua.browser.version || null
  data.ua = ua.ua.substring(0,100) || null

  _entity.records_pv.addRecords data, (err, result)->
    cb err

# JS报错上报
exports.receiveJsError = (req, res, cb)-> 
  data = _common.initInsertData _schema.records_js_error.schema.fields, req.query
  data.timestamp = new Date().valueOf()
  data.ip = _ip.ipToInt _common.getClientIp(req)
  data.ua = req.headers['user-agent'].substring(0,100) || null
  data.url = data.url.split('?')[0].substring(0,100) if typeof data.url is 'string'
  data.message = data.message.split('?')[0].substring(0,300) if typeof data.message is 'string'

  _entity.records_js_error.addRecords data, (err, result)->
    cb err



exports.insert2DB = (req, res, cb)->
  for key, entity of _entity 
    entity.insert2DB() if entity.insert2DB


