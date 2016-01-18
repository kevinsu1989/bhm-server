
fields_1 =
  # 客户端ip
  ip: 'bigInteger'
  # 上报时间
  timestamp: 'bigInteger'
  # 节目id
  video_id: 'integer'
  # ua
  ua: ''
  # status
  status: 'integer'
  # hash
  hash: ''


fields_2 =
  # 客户端ip
  ip: 'bigInteger'
  # 上报时间
  timestamp: 'bigInteger'
  # 节目id
  video_id: 'integer'
  # url
  url: ''
  # ua
  ua: ''
  # 客户端时间
  cli_time: 'bigInteger'


module.exports =

  APP:

    name: 'm_records_app'

    fields: fields_2

  PV:

    name: 'm_records_pv'

    fields: fields_2

  VV:

    name: 'm_records_vv'

    fields: fields_2

  DETAIL:

    name: 'm_records_detail'

    fields: fields_2

  SOURCE:

    name: 'm_records_source'

    fields: fields_2
