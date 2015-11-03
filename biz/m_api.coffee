
_async = require 'async'
_http = require('bijou').http
_ = require 'lodash'
_entity = require '../entity'
_ip = require 'lib-qqwry'
_common = require '../common'

getData = (req)->
  data = 
    timestamp: new Date().valueOf(),
    url: req.query.url || null,
    video_id: req.query.video_id || null,
    ua: req.headers['user-agent'] || null,
    cli_time: req.query.time,
    ip: _ip.ipToInt _common.getClientIp(req)



exports.receiveMPV = (req, res, cb)-> 
  data = getData req
  # console.log 'pv'
  _entity.m_records_pv.addRecords [data], (err, result)->
    cb err

exports.receiveMVV = (req, res, cb)-> 
  data = getData req
  # console.log 'vv'

  _entity.m_records_vv.addRecords [data], (err, result)->
    cb err

exports.receiveMAPP = (req, res, cb)-> 
  data = getData req
  # console.log 'app'

  _entity.m_records_app.addRecords [data], (err, result)->
    cb err

exports.receiveMSource = (req, res, cb)-> 
  data = getData req
  # console.log 's'
  
  _entity.m_records_source.addRecords [data], (err, result)->
      cb err

exports.receiveMDetail = (req, res, cb)-> 
  data = getData req
  # console.log 'd'
  
  _entity.m_records_detail.addRecords [data], (err, result)->
      cb err

