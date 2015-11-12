_BaseEntity = require('bijou').BaseEntity
_redis = require("../redis-connect").redis

class Records extends _BaseEntity
  constructor: ()->
    super require('../schema/records').schema

  addRecords: (list, cb)->
    _redis.lpush 'bhm_records', JSON.stringify(list[0])
    cb null,null


  insert2DB: ()->
    _this = @
    _redis.lrange 'bhm_records', 0, -1, (err, result)->
      console.log result
      return if !result || result.length is 0
      _redis.ltrim 'bhm_records', result.length, -1
      list = JSON.parse "[#{result.toString()}]"
      this.entity().insert(list).exec (err, data)->
        console.log err if err
        console.log "records表于#{new Date().valueOf()}入库#{list.length}条数据" if !err

module.exports = new Records