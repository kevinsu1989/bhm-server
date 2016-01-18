_async = require 'async'
_ = require 'lodash'
_entity = require '../entity'
_ip = require 'lib-qqwry'
_common = require '../common'
_redis = require 'redis'

data_dic = 
  ad: "ad"
  adend: "ad_end"
  cms: "cms"
  play: "play"
  video: "video_load"
  dispatch: "dispatch"
  bufferfull: "buffer_full"


getFlashData = (req)->
  data = 
    timestamp: new Date().valueOf(),
    url: req.query.url || null,
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


exports.receive = (req, res, cb)-> 
  data = getFlashData req

  data.ad_time = req.query.ad_time || 0 if req.params.name in ['ad', 'adend', 'play']

  _entity["records_flash_#{data_dic[req.params.name]}"]?.addRecords data, (err, result)->

  cb null,null
