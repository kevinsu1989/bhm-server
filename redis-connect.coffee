_config = require './config'
_redis = require 'node-redis'
_redis_config = _config.redis

client = _redis.createClient(_redis_config.port, _redis_config.host)

client.on("error", (error)->
  console.log error
)

client.on("ready", ()->
  console.log 'Redis is ok!'
)


exports.redis = client