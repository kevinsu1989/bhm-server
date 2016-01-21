_BaseEntity = require('bijou').BaseEntity
_redis = require("../redis-connect").redis

class Records extends _BaseEntity


  insert2DB: (table_name,redis_name)->
    _this = @

    _redis.lrange redis_name, 0, -1, (err, result)->
      return if !result || result.length is 0

      _redis.ltrim redis_name, result.length, -1

      list = JSON.parse "[#{result.toString()}]"

      _this.entity(table_name).insert(list).exec (err, data)->
        console.log err if err
        console.log "#{table_name}表于#{new Date().toString()}入库#{list.length}条数据" if !err

module.exports = new Records