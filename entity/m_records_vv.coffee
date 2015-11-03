_BaseEntity = require('bijou').BaseEntity
_async = require 'async'
_ = require 'lodash'


class MRecordsVV extends _BaseEntity
    constructor: ()->
      super require('../schema/m_records_vv').schema


    addRecords: (list, cb)->
      @entity().insert(list).exec (err, data)->
        cb err, data

module.exports = new MRecordsVV