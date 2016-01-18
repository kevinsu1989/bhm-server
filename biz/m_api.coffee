
_async = require 'async'
_http = require('bijou').http
_ = require 'lodash'
_entity = require '../entity'
_ip = require 'lib-qqwry'
_common = require '../common'
_redis = require 'redis'

getData = (req)->
  data = 
    timestamp: new Date().valueOf(),
    url: req.query.url || null,
    video_id: req.query.video_id || null,
    ua: req.headers['user-agent'].substring(0,100) || null,
    cli_time: req.query.time,
    ip: _ip.ipToInt _common.getClientIp(req)
    
  data.url = data.url.split('?')[0].substring(0,100) if typeof data.url is 'string'

  data

getDataN = (req)->
  data = 
    timestamp: new Date().valueOf(),
    ua: req.headers['user-agent'].substring(0,100) || null,
    video_id: req.query.video_id || null,
    ip: _ip.ipToInt _common.getClientIp(req)
    
  data.hash = req.query.video_id + data.ip

  data


exports.receive = (req, res, cb)-> 
  data = getDataN req
  
  _entity["m_records_#{req.params.name}"]?.addRecords data, (err, result)->

  cb null,null

