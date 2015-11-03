#    Author: 苏衎
#    Date: 3/19/15 11:20 AM
#    Description: 处理路由
_async = require 'async'
_http = require('bijou').http

# _config = require './config'
_api = require './biz/api'
_mapi = require './biz/m_api'
_cluster = require 'cluster'

receiveData = (req, res, next)->
  _api.receiveData req, res, (err, result)-> _http.responseJSON err, result, res

receiveFlashLoad = (req, res, next)->
  _api.receiveFlashLoad req, res, (err, result)-> _http.responseJSON err, result, res

receiveMPV = (req, res, next)->
  _mapi.receiveMPV req, res, (err, result)-> _http.responseJSON err, result, res

receiveMVV = (req, res, next)->
  _mapi.receiveMVV req, res, (err, result)-> _http.responseJSON err, result, res

receiveMAPP = (req, res, next)->
  _mapi.receiveMAPP req, res, (err, result)-> _http.responseJSON err, result, res

receiveMSource = (req, res, next)->
  _mapi.receiveMSource req, res, (err, result)-> _http.responseJSON err, result, res

receiveMDetail = (req, res, next)->
  _mapi.receiveMDetail req, res, (err, result)-> _http.responseJSON err, result, res


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

  app.get '/api/flash', receiveFlashLoad

  app.get '/api/m/pv', receiveMPV

  app.get '/api/m/vv', receiveMVV

  app.get '/api/m/app', receiveMAPP

  app.get '/api/m/source', receiveMSource

  app.get '/api/m/detail', receiveMDetail

  



