_async = require 'async'
_ = require 'lodash'
_entity = require '../entity'
_ip = require 'lib-qqwry'
_common = require '../common'
_redis = require("../redis-connect").redis

data_dic = 
  js: "js"
  flash: "flash"


# flash加载成功上报
exports.receiveFlashLoad = (req, res, cb)-> 
  data = getFlashData(req)

  data.load_time = req.query.load_time || 0

  _entity.records_flash.addRecords data, (err, result)->
    cb err


exports.receive = (req, res, cb)-> 
  data = getFlashData req

  data.ad_time = req.query.ad_time || 0 if req.params.name in ['ad', 'adend', 'play']

  _redis.lpush "bhm:records:error:#{req.params.name}", JSON.stringify(data)

  cb null,null
