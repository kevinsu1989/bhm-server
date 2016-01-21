

module.exports =
  database:
    client: 'mysql',
    connection:
      # host     : '192.168.8.108',
      # user     : 'root',
      # password : '123456',
      host     : '123.59.21.19'
      user     : 'bhm-server',
      password : 'hunantv.com~front',
      # user     : 'root'
      # password : 'hunantv.com~110629962'
      database : 'monitor'

  redis:
    host: "127.0.0.1"
    port: 6379

  api_runner: 'app.coffee'

  table_redis:
    m_records_app: "bhm:m:records:app"
    m_records_datail: "bhm:m:records:datail"
    m_records_pv: "bhm:m:records:pv"
    m_records_source: "bhm:m:records:source"
    m_records_vv: "bhm:m:records:vv"

    records: "bhm:records"
    records_pv: "bhm:records:pv"

    records_flash: "bhm:records:flash"
    records_flash_ad: "bhm:records:flash:ad"
    records_flash_ad_end: "bhm:records:flash:adend"
    records_flash_buffer_full: "bhm:records:flash:bufferfull"
    records_flash_cms: "bhm:records:flash:cms"
    records_flash_dispatch: "bhm:records:flash:dispatch"
    records_flash_play: "bhm:records:flash:play"
    records_flash_video_load: "bhm:records:flash:videoload"


