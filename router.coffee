#    Author: 苏衎
#    Date: 3/19/15 11:20 AM
#    Description: 处理路由
_async = require 'async'
_http = require('bijou').http

# _config = require './config'
_api = require './biz/api'
_mapi = require './biz/m_api'
_fapi = require './biz/flash'
_errapi = require './biz/error'
_cluster = require 'cluster'

#################
receiveData = (req, res, next)->
  _api.receiveData req, res, (err, result)-> _http.responseJSON err, result, res

receivePV = (req, res, next)->
  _api.receivePV req, res, (err, result)-> _http.responseJSON err, result, res

receiveJsError = (req, res, next)->
  _api.receiveJsError req, res, (err, result)-> _http.responseJSON err, result, res

#################
receiveFlashLoad = (req, res, next)->
  _api.receiveFlashLoad req, res, (err, result)-> _http.responseJSON err, result, res

#################


receiveMobile = (req, res, next)->

  _mapi.receive req, res, (err, result)-> _http.responseJSON err, result, res


receiveFlash = (req, res, next)->

  _fapi.receive req, res, (err, result)-> _http.responseJSON err, result, res

receiveError = (req, res, next)->

  _errapi.receive req, res, (err, result)-> _http.responseJSON err, result, res


#初始化路由
exports.init = (app)->

  app.all '*', (req, res, next)->
    res.header("Access-Control-Allow-Origin", "*")
    res.header("Access-Control-Allow-Headers", "X-Requested-With")
    res.header("Access-Control-Allow-Methods","PUT,POST,GET,DELETE,OPTIONS")
    res.header("X-Powered-By",' 3.2.1')
    res.header("Content-Type", "application/json;charset=utf-8")
    next()
  #常规请求
  app.get '/api/receive', receiveData

  app.get '/api/pv', receivePV

  app.get '/api/js/error', receiveJsError

  app.get '/api/m/:name', receiveMobile
  
  app.get '/api/flash/:name', receiveFlash

  app.get '/api/flash', receiveFlashLoad

  app.get '/api/err/:type', receiveError

  app.get '/api/js/error', receiveJsError




  



