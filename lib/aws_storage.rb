require 'aws-sdk'


#LOGIC
#------




#Configuration
#-------------
#storage directory
IMAGE_CONTAINER="./public/image_container"
Dir.mkdir "./public" unless Dir.exists? "./public"
Dir.mkdir IMAGE_CONTAINER unless Dir.exists? IMAGE_CONTAINER


config_path=File.join File.dirname(__FILE__),"./aws_key.yaml"
config=YAML.load (File.read config_path)


#AWS.config config


# Connection
#------------
$s3 = AWS::S3.new config
bucket_name="alg_images"
#b = s3.buckets.create(bucket_name)

#make or connect to bucket
#takes bucket name
#return bucket
#--------------------------
def bucket bucket_name="alg_images"
  image_store=$s3.buckets[bucket_name]
  unless image_store.exists?
    puts "Need to make bucket #{bucket_name}.."
    $s3.buckets.create(bucket_name)
    image_store=$s3.buckets[bucket_name]
  end
  image_store
end




#save a file
#takes a bucket and a filename
#saves file in S3
#return bucket url
def save bucket, filename
  basename=File.basename filename
  o=bucket.objects[basename]
  o.write (File.read filename)
  #return o.public_url
  return (o.url_for(:read)).to_s
end





#File Writing in Storage
#------------------------
def unique_file_name username,algname,nodeid,old_filename
  basepath=File.join(IMAGE_CONTAINER,username)
  Dir.mkdir basepath unless Dir.exists? basepath
  algdir=File.join(basepath,algname)
  Dir.mkdir algdir unless Dir.exists? algdir
  nodedir=File.join(algdir,nodeid)
  Dir.mkdir nodedir unless Dir.exists? nodedir
  #ext=File.extname old_filename
  new_file_name=username+"_"+algname+"_"+nodeid+old_filename
  File.join(nodedir, new_file_name)
end
  
#takes fileIO and writes file
#works during upload
def write_file filename, fileIO
  fh=File.open(filename,"w")
  data=Base64.decode64(fileIO.read)
  fh.write data
  fh.close
end

#File conversions 
#--------------------
#(thumbs, standrdt size for storage)


#makes thumbs
def make_thumb filename
  command="mogrify -format gif -thumbnail 150x150 #{filename}"
  spawn(command)
end

#converts image to a standartd size and to jpg
def make_jpg filename
  ext=File.extname filename
  new_filename=filename.gsub(ext,".jpg")
  if filename==new_filename
    command="convert -scale  1000x800  #{filename} #{new_filename} && rm #{filename}"
  else 
    command="convert -scale  1000x800  #{filename} #{new_filename}"
  end
  puts command
  #needed to use system because spawn rm was faster then the convert...
  spawn(command)
  #spawn("rm #{filename}") unless filename==new_filename
end

def convert filename
  ext=File.extname filename
  new_filename=filename.gsub(ext,".jpg")
  make_thumb filename
  make_jpg filename
end



  



