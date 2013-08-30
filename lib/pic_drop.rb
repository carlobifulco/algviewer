#AMAZON URL
# Change if needed
$EC2="184.73.233.199"

#REDIS DATABASE Number
#change if needed
$RED_N=6
$RED_PASSWORD="redisreallysucks"


#add the current dir  and lib to the load path
my_directory=File.dirname(File.expand_path(__FILE__))
$LOAD_PATH << File.join(my_directory,'/lib')
$LOAD_PATH << my_directory

#stuff we need
require "sinatra"
require "haml"
require "redis"
require "redis-namespace"
require 'json'
require 'base64'
require "pp"
require "pathname"
require 'openssl'
require 'digest/sha1'
require 'base64'
require "uri"
require 'fog'

#AWS S3 configuration
BUCKET_NAME="algviewerimages"
KEY_FILE="./config/aws_key.json" if Dir.exists? "./config"
KEY_FILE="../config/aws_key.json" if Dir.exists?  "../config"

### Aws urls so that files can have restricted permissions of AWS
module AwsSign

  extend self

  def signed_url path
    expire_date=1417548882
    digest = OpenSSL::Digest::Digest.new('sha1')
    can_string = "GET\n\n\n#{expire_date}\n/notationalvelocity/#{path}"
    hmac = OpenSSL::HMAC.digest(digest, "/Mhw95UKYckAiSAMYkEFmGJ+C+E+R+zPLnAtx34n", can_string)
    signature = URI.escape(Base64.encode64(hmac).strip).encode_signs
    "https://s3.amazonaws.com/notationalvelocity/#{path}?AWSAccessKeyId=1S7EGP373356GW3BHMG2&Expires=#{expire_date}&Signature=#{signature}"
  end
end



class String
  def encode_signs
    signs = {'+' => "%2B", '=' => "%3D", '?' => '%3F', '@' => '%40',
      '$' => '%24', '&' => '%26', ',' => '%2C', '/' => '%2F', ':' => '%3A',
      ';' => '%3B', '?' => '%3F'}
    signs.keys.each do |key|
      self.gsub!(key, signs[key])
    end
    self
  end
end

#### Creates new filenames for S3 like d-renamed-2012-12-29-23-31-34--0800.png
#
# takes file_path
#
# returns unique string with time incorporated
def new_name file_path="./test/test.txt"
  ext_name=File.extname(file_path)
  base_name=File.basename(file_path).gsub ext_name,""
  (base_name+"-"+Time.now.to_s).gsub(" ", "-").gsub(":","-")+ext_name
end



####Logs in aws after heaving read config file
class Uploader
  attr_reader :connection, :directories, :directories_keys,  :bucket

  ####Setup connection and read names of buckets
  #
  # if testing is true do mock
  #
  # Returns self
  def initialize(testing=false)
    @testing=testing
    if testing == true  then Fog.mock! else Fog.unmock! end
    config=JSON.parse File.read KEY_FILE
    con_parameters={
      :provider => 'AWS',
      :aws_access_key_id => config["key"],
      :aws_secret_access_key => config["secret"]
    }
    @connection = Fog::Storage.new(con_parameters)
    @directories=@connection.directories
    @directories_keys=@directories.map{|d| d.key}
    @directories.create( :key=> BUCKET_NAME,:public => true) unless directories_keys.include? BUCKET_NAME
    @bucket=directories.get BUCKET_NAME
  end

  def to_s
    "Uploader: #{self.connection}"
  end

  ####Uploads a file to S3
  #
  # takes filepath
  #
  # returns new URL
  def upload file_path="../test/test.txt"
    puts "uploading #{file_path}"

    #spaced filenames
    file_path_space_cleaned=file_path.gsub "\%20" , "\ "
    if File.exists? file_path_space_cleaned
      puts "finally uploading"
      new_file_name=new_name(file_path_space_cleaned)
      #public is false
      s3_file = @bucket.files.create(
        :key => new_file_name,
        :body => File.open(file_path_space_cleaned),
        :public => false)
      puts "done uploading #{new_file_name}"
      #returns URL for access
      AwsSign.signed_url new_file_name
      #s3_file.public_url
    else
      puts "Cannot find #{file_path}!!!"
    end
  end
end

##### GLobal uploader predifined for out connectionand bucket
$u=Uploader.new


#### Some kind of FileDataStructure for all this uploading business
#loads data and creates new name
class FileData
  attr_accessor  :first_name, :last_name, :case_number, :user
  def initialize file_path
    @file_path=file_path
  end
  def new_name
    "#{(File.basename @file_path).gsub((File.extname @file_path),"")}_#{@case_number}_#{@first_name}_#{@last_name}_#{@user}_#{File.extname @file_path}"
  end
  def new_path
    STATIC_UPLOADS+"/"+self.new_name
  end
  def move
    FileUtils.mv(@file_path, self.new_path)
  end
end

def new_names file_data


end


def move_and_destroy file_path, destination_path
   FileUtils.mv(file_path, destination_path)
end








#SINATRA SETUPS
#----------------
set :root, my_directory
set :haml, {:format => :html5 }
# Keeping coffee, compiled JS and haml files in the same directory
set :views, Proc.new { File.join(root, "public/views") }
enable :sessions


#SERVER and REDIS SETUP
#----------------
# redis server


# location of svg REST service and REDIS. localhost if test
# command line ruby main.rb test

if $0 == __FILE__
  puts ARGV
  puts "SETTINGS port #{settings.port}"
  if ARGV.length !=0 and  ARGV[0]=="test"
    # choosing local server if test parameter, otherwise go to ec2
    $HOST="0.0.0.0"
    puts "sinatra  running locally at  at http://#{$HOST}:#{settings.port}; redis also on same #{$HOST}"
  else
    $HOST=$EC2
    puts "running at EC2 at http://#{$HOST}:#{settings.port}; redis also on same #{$HOST}"
  end
end
#username name_space
$user_name_name_space="pic_drop_name_space"

#storage directory
IMAGE_CONTAINER="./public/image_container"
Dir.mkdir "./public" unless Dir.exists? "./public"
Dir.mkdir IMAGE_CONTAINER unless Dir.exists? IMAGE_CONTAINER


#Redis connection
$REDIS=Redis.new(:thread_safe=>true,:port=>6379,:host=>$HOST)
$REDIS.select 10

# to create named instances
def redis_name_spaced name_space
  Redis::Namespace.new(name_space, :redis =>$REDIS)
end


#checking if redis is setup
def check_redis
  r=redis_name_spaced("test")
  begin
    r.set("test",232323)
    r.del("test")
  rescue Exception => e
    puts e.message
    puts e.backtrace.inspect
    puts "REDIS NOT FOUND or UNABLE to CONNECT to IT"
    puts "stopping now"
    raise "Error, no redis"
  end
end
check_redis()


def image_url file_name,username
  "#/image/username/#{file_name}"
end





#File Writing in Storage
#------------------------

#make a unique filename nand proper directory structure
#also make sure that the basepath to the file exists
#uses the username/algname/nodeid to form a user specific directory
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
def write_file filename, fileIO
  fh=File.open(filename,"w")
  data=Base64.decode64(fileIO.read)
  fh.write data
  fh.close
end

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



# ROUTES
#----------


#AJAX
#------



#upload is a post with a param file and sub filename and tempfile
#the url contains info on the link
#the redis key is composed of username+_algname+_+nodeid
post '/upload/:username/:algname/:nodeid' do
  username=params["username"]
  algname=params['algname']
  nodeid=params['nodeid']
  fileIO=request.env["rack.input"]
  old_filename=request.env["HTTP_UP_FILENAME"].gsub(" ","_")
  pp request.env
  #get filename and creates appropriate directories
  filename=unique_file_name(username,algname,nodeid,old_filename)
  #writes file
  write_file filename, fileIO
  #make a thumb and convert to jpg
  make_thumb filename
  make_jpg filename
  r= Redis::Namespace.new(username, :redis =>$REDIS)
  #one node in an alg can have many images
  file_key=username+"_"+algname+"_"+nodeid
  # one node/set of files
  r.sadd file_key, filename
  #./public/image_container/guest2/test/94/guest2_test_94a_test.png has key of guest2_test_94
  puts "#{filename} has key of #{file_key}"
  puts r.smembers file_key
  puts (r.smembers file_key).class
end

# returns images from a directoru
def images_from_dir dirname
  query="#{dirname}/**/*"
  r=Dir.glob query
  # removes directories and thumbnails ".gif"
  r.select! {|e| not (File.directory?(e) or File.extname(e)==".gif")}
  #makes an usable url
  r.collect! {|e| e.gsub "./public", ""}
  puts query
  puts r
  r.to_json
end


# returns thumbs from directoru
def thumbs_from_dir dirname
  query="#{dirname}/**/*"
  r=Dir.glob query
  # removes directories and thumbnails ".gif"
  r.select! {|e| File.extname(e)==".gif"}
  #makes an usable url
  r.collect! {|e| e.gsub "./public", ""}
  puts query
  puts r
  r.to_json
end

#get images for node
get '/images/:username/:algname/:nodeid' do
  username=params["username"]
  algname=params['algname']
  nodeid=params['nodeid']
  basepath=File.join(IMAGE_CONTAINER,username)
  algdir=File.join(basepath,algname)
  nodedir=File.join(algdir,nodeid)
  images_from_dir nodedir
end


#get thumbs for node
get '/thumbs/:username/:algname/:nodeid' do
  username=params["username"]
  algname=params['algname']
  nodeid=params['nodeid']
  basepath=File.join(IMAGE_CONTAINER,username)
  algdir=File.join(basepath,algname)
  nodedir=File.join(algdir,nodeid)
  thumbs_from_dir nodedir
end

#get all thumbs for alg
get '/thumbs/:username/:algname' do
  username=params["username"]
  algname=params['algname']
  nodeid=params['nodeid']
  basepath=File.join(IMAGE_CONTAINER,username)
  algdir=File.join(basepath,algname)
  thumbs_from_dir algdir
end




#returns List with names of nodes who have files
get '/nodes_with_images/:username/:algname' do
  username=params["username"]
  algname=params['algname']
  basepath=File.join(IMAGE_CONTAINER,username)
  algdir=File.join(basepath,algname)
  query="#{algdir}/*"
  r=Dir.glob query
  # keep only directories"
  r.select! {|e| File.directory?(e)}
  r.collect! {|e| File.basename e}
  r.to_json
end



#get all images for alg
get '/images/:username/:algname' do
  username=params["username"]
  algname=params['algname']
  basepath=File.join(IMAGE_CONTAINER,username)
  algdir=File.join(basepath,algname)
  images_from_dir algdir
end


# SIMPLE ROUTES

# redirected main page

if $0 == __FILE__

  get "/" do
    #example for redis
    haml :pic_drop
  end
end

get '/galleria/:algname/:nodeid' do
  haml :galleria
end

get '/galleria/:algname' do
  haml :galleria
end


#
# #get all images for a username
# def get_images(username)
#   images_names=[]
#   r= Redis::Namespace.new(username, :redis =>$REDIS)
#   #>> r.keys
#   #=> ["tester_algname_68", "tester_algname_19"]
#   r.keys.each do |k|
#     # >> r.smembers "tester_algname_68"
#     # => ["tester_algname_68_2011-04-04_23:48:58_-0700"]
#     images_names<<(r.smembers k)
#   end
#   images_names.flatten!
# end
#
#
# #userspace the ket setmembers for each key
# get '/show_all_images/:username' do
#   username=params["username"]
#   @images_names=get_images username
#   haml :show_images
# end



# get "/galleria/:username/:algname/:nodeid" do
#   username=params["username"]
#   algname=params['algname']
#   nodeid=params['nodeid']
#   r= Redis::Namespace.new(username, :redis =>$REDIS)
#   file_key=make_node_name username, algname,nodeid
#   @images_names=r.sget file_key
#   haml :galleria
# end
#
#
#
# #show galleria for a specific node
# get "/galleria/:username/:algname/:nodeid" do
#   username=params["username"]
#   algname=params['algname']
#   nodeid=params['nodeid']
#   r= Redis::Namespace.new(username, :redis =>$REDIS)
#   file_key=make_node_name username, algname,nodeid
#   @images_names=r.sget file_key
#   haml :galleria
# end


# get '/all_images/:username' do
#   username=params["username"]
#   r= Redis::Namespace.new(username, :redis =>$REDIS)
#   r.keys.to_json
# end


# get '/all_images' do
#   all=[]
#   $REDIS.keys.each do |k|
#     puts k
#     #need to skip the username login info....
#     begin
#       all << ($REDIS.smembers k)
#     rescue  Exception => e
#       puts e.message
#       puts e.backtrace.inspect
#     end
#   end
#   all.to_s
# end



