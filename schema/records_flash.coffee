fields =
  load: 
    # 客户端ip
    ip: 'bigInteger'
    # 上报时间
    timestamp: 'bigInteger'
    # flash加载时间
    load_time: 'integer'
    # 上报的url
    url: ''
    # 本次上报的hash
    hash: ''
    # 服务端版本
    server_version: ''
    # 客户端版本
    cli_version: ''
    # 客户端上报时间
    cli_time: ''
  ad:
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
  normal:
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
    # 客户端上报时间
    cli_time: ''



module.exports =

  LOAD:

	  name: 'records_flash'

	  fields: fields.load

  AD:

    name: 'records_flash_ad'

    fields: fields.ad

  AD_END:

    name: 'records_flash_ad_end'

    fields: fields.ad

  AD_PLAY:

    name: 'records_flash_play'

    fields: fields.ad

  BUFFER_FULL:

    name: 'records_flash_buffer_full'

    fields: fields.normal

  CMS:

    name: 'records_flash_cms'

    fields: fields.normal

  DISPATCH:

    name: 'records_flash_dispatch'

    fields: fields.normal

  VIDEO_LOAD:

    name: 'records_flash_video_load'

    fields: fields.normal
