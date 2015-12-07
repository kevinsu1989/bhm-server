_BaseEntity = require('bijou').BaseEntity
_redis = require("../redis-connect").redis

class RecordsPV extends _BaseEntity
  constructor: ()->
    super require('../schema/records_pv').schema


  addRecords: (record, cb)->
    _redis.lpush 'bhm_pv', JSON.stringify(record)
    cb null, null


  insert2DB: ()->
    _this = @
    _redis.lrange 'bhm_pv', 0, -1, (err, result)->
      return if !result || result.length is 0
      _redis.ltrim 'bhm_pv', result.length, -1
      list = JSON.parse "[#{result.toString()}]"
      _this.entity().insert(list).exec (err, data)->
        console.log err if err
        console.log "records_pv表于#{new Date().toString()}入库#{list.length}条数据" if !err

module.exports = new RecordsPV