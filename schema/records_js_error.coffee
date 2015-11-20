exports.schema =
  name: 'records_js_error'

  fields:
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