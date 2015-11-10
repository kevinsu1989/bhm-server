_BaseEntity = require('bijou').BaseEntity
_redis = require("../redis-connect").redis

class Records extends _BaseEntity
  constructor: ()->
    super require('../schema/records').schema

  addRecords: (list, cb)->
    _this = @
    _redis.lrange 'bhm_records', 0, -1, (err, result)->
      if result and result.length >= 100
        _redis.ltrim 'bhm_records', result.length, -1
        list = JSON.parse "[#{result.toString()}]"
        _this.entity().insert(list).exec (err, data)->
          cb err, data
      else
        _redis.lpush 'bhm_records', JSON.stringify(list[0])
        cb null,null

module.exports = new Records