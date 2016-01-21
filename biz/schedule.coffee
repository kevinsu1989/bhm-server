_schedule = require 'node-schedule'
_entity = require '../entity'
_child = require 'child_process'
_async = require 'async'
_config = require '../config'


inert2DB = ()->
  console.log new Date()

  index = 0

  table_redis = _config.table_redis
  
  for table, redis of table_redis
    ((table, redis)->
      setTimeout(()->
          _entity.main.insert2DB(table, redis) 
      , (index++) * 3 * 1000)
    )(table, redis)



exports.initSchedule = ()->
  inert2DB()
  rule_mi = new _schedule.RecurrenceRule()

  rule_mi.second = 0

  mi = _schedule.scheduleJob rule_mi, inert2DB
