module.exports =

  TOKEN: 'behappy' 

  KEYROUTE: ['/api/preview', '/api/refresh', '/api/deploy']

  database:
    client: 'mysql',
    connection:
      # host     : '123.59.21.19'
      # user     : 'root'
      # password : 'hunantv.com~110629962'
      host     : '192.168.8.108'
      user     : 'root'
      password : '123456'
      database : 'dollargan'

  PREVIEW:
    HOST: 'http://10.200.8.234'
    PORT: 15000
    hash: 'dollargan:hash:preview'
    STATICPORT: 8000
    PRE_DEPLOY: 'http://10.100.5.113:8000'

  redis:
    host: "127.0.0.1"
    port: 6379
    hash: 'dollargan'

  MAID: 
    request: "http://10.200.8.234:9800"
    token: 'a621f4eb-39e0-4c91-9bef-a9c067a505cf' 
    hash: 'dollargan:hash:maid'
    queue: 'dollargan:queue:maid'
    fail: 'dollargan:fail:maid'
    concurrency: 50
    host: '123.59.21.92'
    port: 9000


  SILKY: 
    hash: 'dollargan:hash:silky'
    queue: 'dollargan:queue:silky'
    fail: 'dollargan:fail:silky'
    concurrency: 5
    preview: 'http://127.0.0.1:1530/api/build'
    deploy: 'http://127.0.0.1:1530/api/deploy'
    release: 'http://127.0.0.1:1518/api/release'

  VRS:
    SERVER: '192.168.8.65'
    PORT: 5672
    QUEUE: 'queue_ucms'
    USER: 'guest'
    PASSWD: 'guest'
    CALLBACK: 'http://10.1.201.111:8001/api/BuildCallback/CMSBuildCallBack'
    
  TASK: 
    TIMEOUT: 60000
    RETRY: 3
    QUEUEFILE: './queue.file'
    HASHTABLEFILE: './hashtable.file'
    

  LOG:
    DIR: "/data/logs/dollargan.log"
  
