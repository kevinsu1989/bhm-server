_BaseEntity = require('bijou').BaseEntity
_async = require 'async'
_ = require 'lodash'


class MRecordsPV extends _BaseEntity
    constructor: ()->
      super require('../schema/m_records_pv').schema


    addRecords: (list, cb)->
      @entity().insert(list).exec (err, data)->
        cb err, data

module.exports = new MRecordsPV