_BaseEntity = require('bijou').BaseEntity
_redis = require("../redis-connect").redis

class RecordsJsError extends _BaseEntity
  constructor: ()->
    super require('../schema/records_flash').schema


  addRecords: (record, cb)->
    _redis.lpush 'bhm_error_js', JSON.stringify(record)
    cb null, null


  insert2DB: ()->
    _this = @
    _redis.lrange 'bhm_error_js', 0, -1, (err, result)->
      return if !result || result.length is 0
      _redis.ltrim 'bhm_error_js', result.length, -1
      list = JSON.parse "[#{result.toString()}]"
      _this.entity().insert(list).exec (err, data)->
        console.log err if err
        console.log "records_error_js表于#{new Date().toString()}入库#{list.length}条数据" if !err

module.exports = new RecordsJsError