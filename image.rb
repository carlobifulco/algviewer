require "nestful"
require "sinatra"
require "tempfile"
require "pathname"
require "redis"
require 'json/pure'
require_relative "./tree_struct"



$redis3=Redis.new
UseDb=3
$redis3.select UseDb

#needs to be changed in deployment
$HOME="http://0.0.0.0:4567"
IMAGE_CONTAINER="./image_container"

def image_url file_name
  "#{$HOME}/image/#{file_name}"
end


set :haml, {:format => :html5 }
enable :sessions


Dir.mkdir IMAGE_CONTAINER unless Dir.exists? IMAGE_CONTAINER

module Setup
  
  def check_redis()
    $redis3.select ConfigurationDb
    begin
      $redis3.get "liame"
    rescue
      puts "email missing"
      raise "EMAIL MISSING"
    end
    $redis3.select UseDb
  end
  
 def configuration_set(key,text)
   $redis3.select ConfigurationDb
   $redis3.set key,text
   $redis3.select UseDb
 end
 
 def configuration_get(key)
   $redis3.select ConfigurationDb
   result=$redis3.get key
   $redis3.select UseDb
   result
 end
 
 def clean_redis (a=[])
  $redis3.select UseDb
   r=[]
   $redis3.keys.each do |k|
     r << ($redis3.del k)
   end
   configuration_set "on", "off"
   r
 end
end

def unique_file_name file_name
  # will need ot be fixed
  t=Time.now.to_s.split.join("_")
  File.join(IMAGE_CONTAINER,(t+"_"+file_name))
end
  

post '/upload' do
  session["node_name"]="a" #NODE ADDED
  puts "CALLED /upload"
  puts params
  
  unless params[:file] && (tmpfile = params[:file][:tempfile]) && (name = params[:file][:filename])
    puts "No file selected"
    redirect "/upload_form"
  end

  file_name=unique_file_name(name)
  fh=File.open(file_name,"w")
  fh.write(tmpfile.read)
  fh.close
  $redis3.sadd session["node_name"], (Pathname.new file_name).basename.to_s
  puts file_name
  puts $redis3.smembers "a"
  puts ($redis3.smembers "a").class
  session["uploaded"]=fh.path
  redirect "/upload_form"  
end


get '/reset_redis' do
  ($redis3.smembers session["node_name"]).each do |x|
    puts "#{x} exists? Answer #{(File.exists? File.join(IMAGE_CONTAINER,x))}"
    
    $redis3.srem(session["node_name"],x) unless (File.exists? File.join(IMAGE_CONTAINER,x))
  end
end

get '/image/:file_name' do
  file_name=params[:file_name]
  ext=File.extname(file_name)[1..-1] #
  content_type "image/#{ext}"
  File.open(File.join(IMAGE_CONTAINER,file_name),"r").read()
end

get '/show_images' do
  @images_names=$redis3.smembers session["node_name"] 
  haml :show_images
end

get "/upload_form" do
  if params[:node_hash]
    @node_hash=params[:node_hash] if params[:node_hash]
  else 
    @node_hash="no_node"
  end
  puts @node_hash
  @uploaded=session["uploaded"]
  session["uploaded"]=""
  haml :upload_form
 
end

get "/galleria" do
  @images_names=$redis3.smembers session["node_name"] 
  haml :galleria
end


get '/json' do
  node_name=JSON.parse params[:node_name]
  puts " NODE " + node_name.to_s
  #haml :json
end

get '/' do
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


  
 
 
 





