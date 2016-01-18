_BaseEntity = require('bijou').BaseEntity
_redis = require("../redis-connect").redis

class MRecordsSource extends _BaseEntity
  constructor: ()->
    super require('../schema/records_mobile').SOURCE

  addRecords: (record, cb)->
    _redis.lpush 'bhm_m_records_source', JSON.stringify(record)
    cb null,null


  insert2DB: ()->
    _this = @
    _redis.lrange 'bhm_m_records_source', 0, -1, (err, result)->
      return if !result || result.length is 0
      _redis.ltrim 'bhm_m_records_source', result.length, -1
      list = JSON.parse "[#{result.toString()}]"
      _this.entity().insert(list).exec (err, data)->
        console.log err if err
        console.log "m_records_source表于#{new Date().toString()}入库#{list.length}条数据" if !err
        # cb err, data

module.exports = new MRecordsSource
