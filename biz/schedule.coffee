_schedule = require 'node-schedule'
_entity = require '../entity'
_child = require 'child_process'
_async = require 'async'
_common = require '../common'

_timeline = require './timeline'


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

    for page in result
      ((page)->
        setTimeout(()->
            _timeline.writeFiles page
        , (index++) * 3 * 1000)
      )(page)



exports.initSchedule = ()->

    rule = new _schedule.RecurrenceRule()

    if process.env.TYPE is 'file'
      rule.minute = 0
      work = _schedule.scheduleJob rule, writeFiles
    else
      rule.second = 0
      work = _schedule.scheduleJob rule, inert2DB


