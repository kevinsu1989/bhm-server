
exports.schema =
  name: 'records_flash_video_load'

  fields:
    # 客户端ip
    ip: 'bigInteger'
    # 上报时间
    timestamp: 'bigInteger'
    # 上报的url
    url: ''
    # 本次上报的hash
    hash: ''
    # 客户端版本
    cli_version: ''