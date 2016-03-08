

module.exports =
  database:
    client: 'mysql'
    connection:
      # host     : '192.168.8.108',
      # user     : 'root',
      # password : '123456',
      host     : '123.59.21.19'
      # user     : 'bhm-server'
      # password : 'hunantv.com~front'
      user     : 'root'
      password : 'hunantv.com~110629962'
      database : 'monitor'

  redis:
    host: "127.0.0.1"
    port: 6379

  api_runner: 'app.coffee'

  data_path: '/data/bhm/data'

  err_path: '/data/bhm/err'


