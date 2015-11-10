_BaseEntity = require('bijou').BaseEntity
_redis = require("../redis-connect").redis

class MRecordsDetail extends _BaseEntity
  constructor: ()->
    super require('../schema/m_records_detail').schema

  addRecords: (list, cb)->
    _this = @
    _redis.lrange 'bhm_m_records_detail', 0, -1, (err, result)->
      if result and result.length >= 100
        _redis.ltrim 'bhm_m_records_detail', result.length, -1
        list = JSON.parse "[#{result.toString()}]"
        _this.entity().insert(list).exec (err, data)->
          cb err, data
      else
        _redis.lpush 'bhm_m_records_detail', JSON.stringify(list[0])
        cb null,null

module.exports = new MRecordsDetail