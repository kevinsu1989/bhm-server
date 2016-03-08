_schedule = require 'node-schedule'
_entity = require '../entity'
_child = require 'child_process'
_async = require 'async'

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



exports.initSchedule = ()->

    rule_mi = new _schedule.RecurrenceRule()

    rule_mi.second = 0

    mi = _schedule.scheduleJob rule_mi, inert2DB


