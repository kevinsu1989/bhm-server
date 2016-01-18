fields =
  LOAD: 
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
  AD:
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
  NORMAL:
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

	  fields: fields.LOAD

  AD:

    name: 'records_flash_ad'

    fields: fields.AD

  AD_END:

    name: 'records_flash_ad_end'

    fields: fields.AD

  AD_PLAY:

    name: 'records_flash_play'

    fields: fields.AD

  BUFFER_FULL:

    name: 'records_flash_buffer_full'

    fields: fields.NORMAL

  CMS:

    name: 'records_flash_cms'

    fields: fields.NORMAL

  DISPATCH:

    name: 'records_flash_dispatch'

    fields: fields.NORMAL

  VIDEO_LOAD:

    name: 'records_flash_video_load'

    fields: fields.NORMAL
