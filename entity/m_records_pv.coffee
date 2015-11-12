_BaseEntity = require('bijou').BaseEntity
_redis = require("../redis-connect").redis

class MRecordsPV extends _BaseEntity
  constructor: ()->
    super require('../schema/m_records_pv').schema


  addRecords: (list, cb)->
    _redis.lpush 'bhm_m_records_pv', JSON.stringify(list[0])
    cb null,null


  insert2DB: (cb)->
    _this = @
    _redis.lrange 'bhm_m_records_pv', 0, -1, (err, result)->
      return cb null, null if !result || result.length is 0
      _redis.ltrim 'bhm_m_records_pv', result.length, -1
      list = JSON.parse "[#{result.toString()}]"
      this.entity().insert(list).exec (err, data)->
        console.log err if err
        console.log "m_records_pv表于#{new Date().valueOf()}入库#{list.length}条数据" if !err
        cb err, data

module.exports = new MRecordsPV