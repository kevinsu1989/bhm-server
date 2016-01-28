_path = require 'path'
_bijou = require 'bijou'
_async = require 'async'
_ = require 'lodash'
_config = require './config'
_schedule = require './biz/schedule'
_fs = require 'fs-extra'

_em = require './entity/main'

#初始化bijou
initBijou = (app)->
  options =
    log: process.env.DEBUG
    #指定数据库链接
    database: _config.database
    #指定路由的配置文件
    routers: []

  _bijou.initalize(app, options)

  queue = []
  queue.push(
    (done)->
      #扫描schema，并初始化数据库
      schema = _path.join __dirname, './schema'
      _bijou.scanSchema schema, done
  )

  _async.waterfall queue, (err)->
    console.log err if err
    if process.env.SCHEDULE
      console.log 'BHM Server-Schedule is running now!'
    else
      console.log 'BHM Server is running now!'
      console.log "需要同时开启定时入库进程--SCHEDULE=true".red


module.exports = (app)->
  console.log "启动中..."
  require('./router').init(app)
  initBijou app
  _schedule.initSchedule() if process.env.SCHEDULE

