_redis = require("../redis-connect").redis


exports.receive = (req, res, cb)-> 

  data = req.query

  _redis.lpush "bhm:records:timeline:#{req.params.name}", JSON.stringify(data)

  cb null,null
