_BaseEntity = require('bijou').BaseEntity
_redis = require("../redis-connect").redis


class RecordsFlash extends _BaseEntity
  constructor: ()->
    super require('../schema/records_flash').schema


  addRecords: (list, cb)->
    _redis.lrange 'bhm_flash', 0, -1, (err, result)->
      if result and result.length >= 100
        list = JSON.parse "[#{result.toString()}]"
        @entity().insert(list).exec (err, data)->
          _redis.ltrim 'bhm_flash', list.length, -1
          cb err, data
      else
        _redis.lpush 'bhm_flash', JSON.stringify(list[0])
        cb null,null


module.exports = new RecordsFlash