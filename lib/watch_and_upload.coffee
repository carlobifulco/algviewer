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
repl = require("repl")




run=(command)->
  exec "#{command}", (stdin,stdout,err)-> 
    if err
      console.log "#{command} err: #{err}"
      return 
    console.log "#{command} stdout: #{stdout}"


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
PATH= "./public"

has_key=(h,k)->
  k in u_.keys(h)

####make nested dirs
#test bed for destructions
nested_dirs=["1","2","3","4","5"]

nest=()->
  nests=["."]
  for i in nested_dirs
    nests.push i
    console.log "my pushed array #{i}"
    dirname=nests.reduce (a,b)-> path.join a,b
    console.log ("./"+dirname)
    fs.mkdir("./"+dirname,0777)
    
nest_destroy=()->
  nests=["."]
  for i in nested_dirs
    nests.push i
    dirname=nests.reduce (a,b)-> path.join a,b
    #fs.rmdirSync dirname
    run "rm -R #{dirname}"
  


####recursive function
#crawls up and deletes if empty
dir_remove=(filename)->

  dirname=fs.realpathSync(path.dirname(filename))
  if (dirname==fs.realpathSync PATH)
    return
  fs.readdir dirname, (e,d)->console.log d; fs.rmdirSync dirname if d.length==0
  dir_remove path.join(dirname, "..")

  

####watch PATH directory->loop on changes->call upload
watch_public=()->
  #all files in path
  
  #dir watch
  fs.watchFile PATH, (cur,pre)->
    console.log "Changes"
    console.log dead_hash
    finder.find PATH, (filename)->
      upload(filename) if ((not has_key dead_hash,filename) and fs.lstatSync(filename).isFile())
      if fs.readdirSync(path.dirname(filename)).length==0
        fs.rmdirSync(path.dirname filename) 
      else
        console.log "#{filename}, #{fs.readdirSync(pathname.dirname(filename)).length},  #{fs.readdirSync(pathname.dirname(filename))}"
        #console.log fs.readdirSync(pathname.dirname(filename))
      
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
            #delete dir
            dir_remove filename
            
          else
            #errors in upload to amazon
            console.log "ERRORRRRRR"
            console.log res
            delete dead_hash[filename]   
        req.end(buf)

      
  else
    return

debug = (obj, seen)->
  printProps = (obj)->
    #Edge case to handle is [1,2,3][9] = 'foo'
    #Need to factor the conditional out to check if the prop is a number less
    #than the array's length
    return ((if ! /^\d+$/.test prop then prop + ": " + debug(obj[prop], seen) \
      else '') for prop of obj).join(', ')

  seen = seen or []
  if obj in seen
    return '[Circular]'
  seen.push obj
  switch typeof obj
    when 'boolean'
      return obj.toString()
    when 'number'
      return obj.toString()
    when 'string'
      return obj.toString()
    when 'undefined'
      return 'undefined'
    when 'function'
      source = obj.toString()
      return source.slice(0, source.indexOf('{')) + ' {...}'
    else
      if Object.prototype.toString.call(obj) == Object.prototype.toString.call([])
        return '['+ ((debug(item, seen) for item in obj).join(', ')) + ']' + printProps obj
      else
        return (obj or 'null').toString() + printProps obj

module.exports =
  watch_public:watch_public
  upload:upload
  nest:nest

if require.main==module
  r=repl.start()
  r.context.nest= nest
  r.context.nest_destroy=nest_destroy
  r.context.debug=debug
 
#watch_public()

  