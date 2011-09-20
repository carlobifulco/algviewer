#### Rationale
# To send to S3 any file showin up in the storage directory
# after having converted to the proper format and after having generated thumbnails on the local drive
# the storage dir is then kept empty by deleting the uploaded files

fs = require('fs')
sys=require "sys"
exec = require('child_process').exec
util   = require('util')
knox=require "knox"
finder=require("findit")
u_=require "underscore"
path=require "path"
dead_hash={}

#only way I seem to be able to catch exceptions 
# process.on 'uncaughtException',(err)->
#   console.log err

####aws config load
#aws configuration
config=JSON.parse(fs.readFileSync "aws_key.json", "utf8")
config.bucket="alg_images"
s3=knox.createClient config
####file path config
#file path configuration
path= "./public"

has_key=(h,k)->
  k in u_.keys(h)
  

####watch path directory->loop on changes->call upload
watch_public=()->
  #all files in path
  
  #dir watch
  fs.watchFile path, (cur,pre)->
    console.log "Changes"
    finder.find path, (filename)->
      upload(filename) if ((not has_key dead_hash,filename) and fs.lstatSync(filename).isFile())
      
        # console.log "ERROR IN fs.lstatSync: #{err} or in findit"
        #        console.log err
       

####upload files and delete them
upload=(filename)->
  dead_hash[filename]=true
  #no spaces in file name amazon hates them and no directories
  if ((filename.indexOf " ") == -1 and fs.lstatSync(filename).isFile())
    # link errors happen --file deleted and still running stats on it
    fs.readFile filename,(err,buf)->
      if err
        delete dead_hash[filename]
        return 
      b=buf.length
      if (not err) and buf
        o={"Content-Length":b}  
        req=s3.put filename,o
        req.on "response", (res)->
          if res.statusCode==200
            console.log "saved #{req.url}"
            delete dead_hash[filename]
            #delete file
            fs.unlinkSync(filename) if  fs.lstatSync(filename).isFile()
            #will remove directories only if they are empty
            # exec "rmdir -p #{path.dirname(filename)}",(e,i,o)->
            #    console.log e
          else
            #errors in upload to amazon
            console.log "ERRORRRRRR"
            console.log res
            delete dead_hash[filename]   
        req.end(buf)

      
  else
    return


 
watch_public()

  