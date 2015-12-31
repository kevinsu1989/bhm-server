#    Author: 苏衎
#    Date: 3/19/15 11:20 AM
#    Description: 处理路由
_async = require 'async'
_http = require('bijou').http

# _config = require './config'
_api = require './biz/api'
_mapi = require './biz/m_api'
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

receiveFlashAd = (req, res, next)->
  _api.receiveFlashAd req, res, (err, result)-> _http.responseJSON err, result, res

receiveFlashAdEnd = (req, res, next)->
  _api.receiveFlashAdEnd req, res, (err, result)-> _http.responseJSON err, result, res

receiveFlashPlay = (req, res, next)->
  _api.receiveFlashPlay req, res, (err, result)-> _http.responseJSON err, result, res

receiveFlashCMS = (req, res, next)->
  _api.receiveFlashCMS req, res, (err, result)-> _http.responseJSON err, result, res

receiveFlashDispatch = (req, res, next)->
  _api.receiveFlashDispatch req, res, (err, result)-> _http.responseJSON err, result, res

receiveFlashVideoLoad = (req, res, next)->
  _api.receiveFlashVideoLoad req, res, (err, result)-> _http.responseJSON err, result, res

receiveFlashBufferFull = (req, res, next)->
  _api.receiveFlashBufferFull req, res, (err, result)-> _http.responseJSON err, result, res

#################
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

#################

receiveM = (req, res, next)->

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

  app.get '/api/flash/ad', receiveFlashAd

  app.get '/api/flash/adend', receiveFlashAdEnd

  app.get '/api/flash/play', receiveFlashPlay

  app.get '/api/flash/cms', receiveFlashCMS

  app.get '/api/flash/dispatch', receiveFlashDispatch

  app.get '/api/flash/video', receiveFlashVideoLoad

  app.get '/api/flash/bufferfull', receiveFlashBufferFull

  app.get '/api/pv', receivePV

  app.get '/api/js/error', receiveJsError

  app.get '/api/m/pv', receiveMPV

  app.get '/api/m/vv', receiveMVV

  app.get '/api/m/app', receiveMAPP

  app.get '/api/m/source', receiveMSource

  app.get '/api/m/detail', receiveMDetail

  app.get '/api/m/report', receiveM

  



