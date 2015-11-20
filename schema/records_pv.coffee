
exports.schema =
  name: 'records_pv'

  fields:
  	# 客户端ip
    ip: 'bigInteger'
    # 上报时间
    timestamp: 'bigInteger'
    # 上报的url
    url: ''
    # 浏览器
    browser_name: ''
    # 浏览器版本
    browser_version: ''
    # 本次上报的hash
    hash: ''
    # 页面名称
    page_name: ''
    # 客户端版本
    cli_version: ''