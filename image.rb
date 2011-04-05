require "nestful"
require "sinatra"
require "tempfile"
require "pathname"
require "redis"
require 'json/pure'
require "redis-namespace"


#called at startup to make sure that at least these users exist in redis
def set_default_users
  users_pass={
    "guest"=>"guest",
    "carlobifulco"=>"bifulcocarlo",
    "tester"=>"tester",
    "master"=>"master"
  }
  r= Redis::Namespace.new($user_name_name_space, :redis =>$redis3) 
  users_pass.keys.each do |id|
    r.set id,users_pass[id] if not r.get id
  end
end



if $0 == __FILE__
  #SINATRA SETUPS
  #----------------
  set :root, File.dirname(__FILE__)
  set :haml, {:format => :html5 }
  # Keeping coffee, compiled JS and haml files in the same directory
  set :views, Proc.new { File.join(root, "public/views") }
  enable :sessions
# location of svg REST service and REDIS. localhost if test 
  if ARGV.length !=0 and  ARGV[0]=="test"
    # choosing local server if test parameter, otherwise go to ec2
    $HOST="0.0.0.0"
    puts "sinatra  running locally at  at http://#{$HOST}:#{settings.port}; redis also on same #{$HOST}"
  else
    $HOST="184.73.233.199" 
    puts "running at EC2 at http://#{$HOST}:#{settings.port}; redis also on same #{$HOST}"
  end
end


#redis connection
$redis3=Redis.new(:password=>"redisreallysucks",:thread_safe=>true,:port=>6379,:host=>$HOST)
#where usernames are
$user_name_name_space="user_name_name_space"


# ALgs live on 4; files delivered from 0; Images on 3
UseDb=3
$redis3.select UseDb

#default users
set_default_users if $0 == __FILE__




# SVG_URL="http://#{$HOST}:#{settings.port}"


#needs to be changed in deployment
$HOME="http://#{$HOST}:4567"
IMAGE_CONTAINER="./image_container"
Dir.mkdir IMAGE_CONTAINER unless Dir.exists? IMAGE_CONTAINER


def image_url file_name,username
  "#{$HOME}/image/username/#{file_name}"
end


set :haml, {:format => :html5 }
enable :sessions


 



#make a unique filename
#also make sure that the basepath to the file exists
def unique_file_name file_name,username
  # will need ot be fixed
  basepath=File.join(IMAGE_CONTAINER,username)
  t=Time.now.to_s.split.join("_")
  Dir.mkdir basepath unless Dir.exists? basepath
  File.join(basepath,(t+"_"+file_name))
end
  

def make_node_name(username,algname,nodeid)
  #one node in an alg can have many images
   file_key=username+"_"+algname+"_"+nodeid
end

#upload is a post with a param file and sub filename and tempfile
#the url contains info on the link
#the redis key is composed of username+_algname+_+nodeid
post '/upload/:username/:algname/:nodeid' do
  username=params["username"]
  algname=params['algname']
  nodeid=params['nodeid']
  r= Redis::Namespace.new(username, :redis =>$redis3) 

  # if no file redirect
  unless params[:file] && (tmpfile = params[:file][:tempfile]) && (name = params[:file][:filename])
    puts "No file selected"
    redirect "/upload_form"
  end

  file_name=unique_file_name(name)
  fh=File.open(file_name,"w")
  fh.write(tmpfile.read)
  fh.close
  
  #one node in an alg can have many images
  file_key=make_node_name username, algname,nodeid
  r.sadd file_key, (Pathname.new file_name).basename.to_s
  puts "#{file_name} has key of #{file_key}"
  puts $redis3.smembers file_key
  puts ($redis3.smembers file_key).class
  redirect "/upload_form"  
end


get '/reset_redis/:username' do
  username=params["username"]
  r= Redis::Namespace.new(username, :redis =>$redis3) 
  
  (r.smembers session["node_name"]).each do |x|
    puts "#{x} exists? Answer #{(File.exists? File.join(IMAGE_CONTAINER,x))}"
    
    r.srem(session["node_name"],x) unless (File.exists? File.join(IMAGE_CONTAINER,x))
  end
end


#SHOW IMAGES
#-------------

#get all images for a username
def get_images(username)
  r= Redis::Namespace.new(username, :redis =>$redis3) 
  r.keys.each do |k|
    images_names<<(r.smembers k)
  end
  images_names.flatten!
end


#serving images
get '/image/:file_name' do
  file_name=params[:file_name]
  ext=File.extname(file_name)[1..-1] #
  content_type "image/#{ext}"
  File.open(File.join(IMAGE_CONTAINER,file_name),"r").read()
end


#userspace the ket setmembers for each key
get '/show_images/:username' do
  username=params["username"]
  @images_names=get_images username
  haml :show_images
end


#show galleria for a specific node
get "/galleria/:username/:algname/:nodeid" do
  username=params["username"]
  algname=params['algname']
  nodeid=params['nodeid']
  r= Redis::Namespace.new(username, :redis =>$redis3) 
  file_key=make_node_name username, algname,nodeid
  @images_names=r.sget file_key
  haml :galleria
end



get '/image_test' do
  haml :main
end

#  %input{:type=>"hidden", :no_node=>@node_hash}

__END__

@@ layout
\<!DOCTYPE html>
%html{:lang=>"en"}
  %head
    %script{:type=>"application/x-javascript",:src=>"http://ajax.googleapis.com/ajax/libs/jquery/1/jquery.min.js"}
    %script{:src=>"jquery.json-2.2.js",:type=>"application/x-javascript" }
    %script{:src=>"galleria.js",:type=>"application/x-javascript" }
    -# %link{:rel=>"stylesheet", :type=>"text/css", :href=> $HOME}

    %title 
  %body
    =yield

@@ main
%a{:href=>"/upload_form"}
	%p upload
%a{:href=>"/show_images"}
	%p show images
%a{:href=>"/json"}
	%p json
%a{:href=>"/galleria"}
	%p galleria
%a{:href=>"/reset_redis"}
	%p reset redis
%p#test THIS IS A TEST
	
:javascript 
	$(function(){
	$("object").css("color","red");
	$("header").css("color","red");
	$("#test").click(
	  function(){
	    $(this).css("color","yellow")});
	
	});


@@ upload_form
%h1 
  %p Uploaded form:
  %p=@uploaded

-# calls /upload
%form{:action=>"/upload",:method=>"post",:enctype=>"multipart/form-data"}
  %input{:type=>"file",:name=>"file"}
  %input{:type=>"submit",:value=>"Upload"}
  
@@ show_images
%h1 Show Images
%ul
- @images_names.each do |i|
  - href=image_url i
  %a{:href=>href}
    %li=i
    
@@ galleria

%h1 Galleria    
%div#galleria
  -@images_names.each do |i|
    - href=image_url i
    %img{:src=>href, :alt=>"test", :title=>"mytitle"}
  %img{:src=>"http://upload.wikimedia.org/wikipedia/commons/thumb/6/67/Laser_effects.jpg/500px-Laser_effects.jpg"}
  %img{:src=>"http://upload.wikimedia.org/wikipedia/commons/thumb/1/1b/PizBernina3.jpg/500px-PizBernina3.jpg"}
  
:css
  html,body{background:#333}
  .content{color:#eee;font:14px/1.4 "helvetica neue", arial,sans-serif;width:620px;margin:20px auto}
  h1{line-height:1.1;letter-spacing:-1px;}
  a {color:#fff;}
  #galleria{height:400px;}
  


:javascript
  Galleria.loadTheme('themes/classic/galleria.classic.js');
  $('#galleria').galleria();


  
 
 
 





