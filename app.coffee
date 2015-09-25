_express = require 'express.io'
_app = _express()

_config = require './config'

_app.configure(()->
  _app.use(_express.methodOverride())
  _app.use(_express.bodyParser())
  _app.use(_express.cookieParser())

  _ports = []

  _app.set 'port', process.env.PORT || 8201
)

require('./initialize')(_app)

_app.listen _app.get 'port'
console.log "Port: #{_app.get 'port'}, Now: #{new Date()}"