#### Rationale
# To send to S3 any file showin up in the storage directory
# after having converted to the proper format and after having generated thumbnails on the local drive
# the storage dir is then kept empty by deleting the uploaded files

fs = require('fs')
sys=require "sys"
exec = require('child_process').exec
util   = require('util')
knox=require "knox"
_und=require "underscore"
in_upload={}


####aws config load
#aws configuration
config=JSON.parse(fs.readFileSync "aws_key.json", "utf8")
config.bucket="alg_images"
s3=knox.createClient config
####file path config
#file path configuration
path= "./public"



####watch path directory->loop on changes->call upload
watch_public=()->
  #all files in path
  finder=require("findit").find(path)
  #dir watch
  fs.watchFile path, (cur,pre)->
    console.log "Changes"
    try
      files = require('findit').sync(path)
      upload(i) for i in files when fs.lstatSync(i).isFile()
    catch err
      console.log "ERROR IN fs.lstatSync: #{err} or in findit"


####upload files and delete them
upload=(filename)->
  #no spaces in file name amazon hates them
  if (filename.indexOf " ") == -1
    # link errors happen --file deleted and still running stats on it
    try
      fs.readFile filename,(err,buf)->
        try 
          buf.length
        catch err
          return 
        
        if (not err) and buf
          o={"Content-Length":buf.length}
          req=s3.put filename,o
          req.on "response", (res)->
            if res.statusCode==200
              console.log "saved #{req.url}"
              fs.unlinkSync(filename) if  fs.lstatSync(filename).isFile()
            else
              #errors in upload to amazon
              console.log "ERRORRRRRR"
              console.log res
          req.end(buf)
    catch err
      if err==ReferenceError
        console.log "ERROR #{err}"
        return
      else
        console.log "HERE I AM #{err}"
  else
    return


try  
  watch_public()
catch err
  console.log "OUTER LOOP ERROR #{err}"
  watch_public()
  