_schedule = require 'node-schedule'
_entity = require '../entity'
_child = require 'child_process'
_async = require 'async'


inert2DB = ()->
  # console.log _entity
  console.log new Date().valueOf()
  for key, entity of _entity 
    if entity.insert2DB
      entity.insert2DB() 


exports.initSchedule = ()->
  inert2DB()
  rule_mi = new _schedule.RecurrenceRule()

  rule_mi.second = 0

  # mi = _schedule.scheduleJob rule_mi, inert2DB
