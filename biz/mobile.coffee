
_async = require 'async'
_http = require('bijou').http
_ = require 'lodash'
_entity = require '../entity'
_ip = require 'lib-qqwry'
_common = require '../common'
_redis = require("../redis-connect").redis

getData = (req)->
  data = 
    timestamp: new Date().valueOf(),
    url: req.query.url || null,
    video_id: req.query.video_id || null,
    ua: req.headers['user-agent'].substring(0,100) || null,
    cli_time: req.query.time,
    ip: _ip.ipToInt _common.getClientIp(req)
  if req.params.name is 'pv'
    data.cookie = req.query.cookie || null

  data.url = data.url.split('?')[0].substring(0,100) if typeof data.url is 'string'

  data

getDataNew = (req)->
  data = 
    timestamp: new Date().valueOf()
    ua: req.headers['user-agent'].substring(0,100) || null
    video_id: req.query.video_id || null
    url: req.query.url || null
    status: req.query.status || null
    ip: _ip.ipToInt _common.getClientIp(req)
    
  data.hash = req.query.hash + data.ip

  data.cookie = req.query.cookie || null if req.params.name is 'pv'
  
  data


exports.receive = (req, res, cb)-> 

  return cb null, null if req.params.name is 'pv' and (!req.query.act or req.query.act isnt 'pv')

  data = getData req

  _redis.lpush "bhm:m:records:#{req.params.name}", JSON.stringify(data)

  cb null,null

exports.receiveNew = (req, res, cb)-> 

  data = getDataNew req

  _redis.lpush "bhm:mobile:records:#{req.params.name}", JSON.stringify(data)

  cb null,null
