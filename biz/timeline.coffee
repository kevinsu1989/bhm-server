_redis = require("../redis-connect").redis
_request = require 'request'
_fs = require 'fs-extra'


exports.receive = (req, res, cb)-> 

  data = req.query

  delete data.callback

  _redis.lpush "bhm:records:timeline:#{req.params.name}", JSON.stringify(data)

  cb null,null


exports.writeFiles = (page)->
  _redis.lrange page.redis, 0, -1, (err, result)->
  return if !result || result.length is 0
  
  _redis.ltrim page.redis, result.length, -1

  time = _moment();
  path_time = _path.join(time.year().toString(), (time.month()+1).toString(), time.date().toString(), time.hour().toString())
  path = page.path.replace(':time', path_time)

  result = JSON.parse "[#{result.toString()}]"

  _fs.writeFile path, JSON.stringify(result), ()->
    setTimeout(()->
      _request.get "#{page.url}?pagename=#{page.name}&timestamp=#{time.valueOf()}"
    ,10000)
      