fields =
  JS: 
    # 错误信息
    message: ''
    # 上报时间
    timestamp: 'bigInteger'
    # url
    url: ''
    # 出错文件
    script: ''
    # ua
    ua: ''
    # 时间
    timestamp: ''
    # 错误行
    line: 'integer'
    # 错误列
    column: 'integer'
  FLASH:
    ip: 'bigInteger' #ip
    ip_address: 'string' #原始信息
    err_msg: 'string' #错误堆栈
    err_code: 'string' #错误代码
    flash_version: 'string'
    browser_name: 'string'
    browser_version:  'string'
    os: 'string' #操作系统
    user_agent: 'string'
    player_version: 'string'
    video_id: 'string' #视频id
    url: 'string' #来源网址
    timestamp: 'bigInteger'




module.exports =
  JS:

    name: 'records_js_error'

    fields: fields.JS

  FLASH:

    name: 'records_error_flash'

    fields: fields.FLASH

