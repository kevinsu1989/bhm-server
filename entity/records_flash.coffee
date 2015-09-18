
_BaseEntity = require('bijou').BaseEntity
_async = require 'async'
_ = require 'lodash'


class RecordsFlash extends _BaseEntity
    constructor: ()->
      super require('../schema/records_flash').schema


    addRecords: (list, cb)->
      @entity().insert(list).exec (err, data)->
        cb err, data

module.exports = new RecordsFlash