_BaseEntity = require('bijou').BaseEntity

class Records extends _BaseEntity
    constructor: ()->
      super require('../schema/records').schema


    addRecords: (list, cb)->
      @entity().insert(list).exec (err, data)->
        cb err, data

module.exports = new Records