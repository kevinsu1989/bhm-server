
exports.schema =
  name: 'records_flash_ad'

  fields:
  	# 客户端ip
    ip: 'bigInteger'
    # 上报时间
    timestamp: 'bigInteger'
    # 广告时间
    ad_time: 'integer'
    # 上报的url
    url: ''
    # 本次上报的hash
    hash: ''
    # 客户端版本
    cli_version: ''
    # 客户端上报时间
    cli_time: ''