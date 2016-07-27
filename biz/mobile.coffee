
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
    ua: req.headers['user-agent'].substring(0,400) || null
    video_id: req.query.videoId || null
    collection_id: req.query.collectionId || null
    url: req.query.url || null
    status: req.query.status || null
    ip: _ip.ipToInt _common.getClientIp(req)
    version: req.query.version || null

  data.hash = req.query.hash + data.ip

  data.cookie = req.query.cookie || null if req.params.name is 'pv'

  data.cookie = req.query.cookie || null if req.params.name is 'play'

  data.hasAd = req.query.hasAd || null if req.params.name is 'play'

  data.video_id = data.video_id.split('&')[0]

  data.url = data.url.split('?')[0].substring(0,100) if req.params.name is 'pv'

  data.url = data.url.substring(0,450)

  data

getDataBasic = (req)->
  data =
    timestamp: new Date().valueOf()
    ua: req.headers['user-agent'].substring(0,400) || null
    url: req.query.url || null
    ip: _ip.ipToInt _common.getClientIp(req)
    version: req.query.version || null
    first_view: req.query.first_view || 0
    first_paint: req.query.first_paint || 0
    dom_ready: req.query.dom_ready || 0
    load_time: req.query.loadTime || 0
    snail_name: req.query.snail_name || null
    snail_duration: req.query.snail_duration || 0
    refer: req.query.refer || null

  data.hash = req.query.hash + data.ip

  data.url = data.url.substring(0,450)

  data

exports.receive = (req, res, cb)-> 

  return cb null, null if req.params.name is 'pv' and (!req.query.act or req.query.act isnt 'pv')

  data = getData req

  _redis.lpush "bhm:m:records:#{req.params.name}", JSON.stringify(data)

  cb null,null

exports.receiveNew = (req, res, cb)-> 
  data = {}
  if req.params.name is 'receive'
    data = getDataBasic(req) 
  else
    data = getDataNew req

  _redis.lpush "bhm:mobile:records:#{req.params.name}", JSON.stringify(data)

  cb null,null
