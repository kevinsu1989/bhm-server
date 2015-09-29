
exports.schema =
  name: 'records_flash'

  fields:
  	# 客户端ip
    ip: 'bigInteger'
    # 上报时间
    timestamp: 'bigInteger'
    # flash加载时间
    load_time: 'integer'
    # 上报的url
    url: ''
    # 本次上报的hasl
    hash: ''
    # 服务端版本
    server_version: ''