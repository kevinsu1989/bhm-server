_schedule = require 'node-schedule'
_entity = require '../entity'
_child = require 'child_process'
_async = require 'async'
_common = require '../common'

inert2DB = ()->
  console.log new Date()

  index = 0

  id = process.env.WORK || 1

  _entity.main.getTableRedis id, (err, result)->

    for table_redis in result
      ((table, redis)->
        setTimeout(()->
            _entity.main.insert2DB(table, redis) 
        , (index++) * 3 * 1000)
      )(table_redis.table_name, table_redis.redis)

writeFiles = ()->
  console.log new Date()
  index = 0

  id = process.env.WORK || 1

  _entity.main.getFileRedis id, (err, result)->

    for file_redis in result
      ((path, redis)->
        setTimeout(()->
            _common.writeFiles path, redis
        , (index++) * 3 * 1000)
      )(file_redis.path, file_redis.redis)

exports.initSchedule = ()->

    rule = new _schedule.RecurrenceRule()

    if process.env.TYPE is 'file'
      rule.miniute = 0
      work = _schedule.scheduleJob rule, writeFiles
    else
      rule.second = 0
      work = _schedule.scheduleJob rule, inert2DB


