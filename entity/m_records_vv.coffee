_BaseEntity = require('bijou').BaseEntity
_redis = require("../redis-connect").redis

class MRecordsVV extends _BaseEntity
  constructor: ()->
    super require('../schema/m_records_vv').schema


  addRecords: (list, cb)->
    _redis.lpush 'bhm_m_records_vv', JSON.stringify(list[0])
    cb null,null


  insert2DB: ()->
    _this = @
    _redis.lrange 'bhm_m_records_vv', 0, -1, (err, result)->
      return if !result || result.length is 0
      _redis.ltrim 'bhm_m_records_vv', result.length, -1
      list = JSON.parse "[#{result.toString()}]"
      _this.entity().insert(list).exec (err, data)->
        console.log err if err
        console.log "m_records_vv表于#{new Date().toString()}入库#{list.length}条数据" if !err

module.exports = new MRecordsVV