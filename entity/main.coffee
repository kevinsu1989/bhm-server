_BaseEntity = require('bijou').BaseEntity
_redis = require("../redis-connect").redis
_config = require '../config'
_fs = require 'fs-extra'

class Records extends _BaseEntity


  insert2DB: (table_name,redis_name)->
    _this = @

    _redis.lrange redis_name, 0, -1, (err, result)->
      return if !result || result.length is 0

      _redis.ltrim redis_name, result.length, -1

      list = JSON.parse "[#{result.toString()}]"

      _this.entity(table_name).insert(list).exec (err, data)->
        if err
          console.log err 
          _this.writeFile _config.err_path, table_name, list if _config.err_path

        _this.writeFile _config.data_path, table_name, list if _config.data_path
        console.log "#{table_name}表于#{new Date().toString()}入库#{list.length}条数据" if !err




  writeFile: (data_path, table_name, list)->
    date = new Date()
    path = []
    path.push data_path
    path.push [data_path, table_name].join('/')
    path.push [data_path, table_name, date.getFullYear()].join('/')
    path.push [data_path, table_name, date.getFullYear(), date.getMonth() + 1].join('/')
    path.push [data_path, table_name, date.getFullYear(), date.getMonth() + 1,date.getDate()].join('/')
    for _path in path
      _fs.mkdirSync _path if !_fs.existsSync _path
    _fs.writeFile "#{path.pop()}/#{date.getHours()}-#{date.getMinutes()}", JSON.stringify(list)


  getTableRedis: (id, cb)->
    sql = "select table_name, redis from table_redis where work = #{id}" 

    @execute sql, cb


module.exports = new Records