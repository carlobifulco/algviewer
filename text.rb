require "nestful"
require "sinatra"
require "tempfile"
require "pathname"
require "redis"
require 'json'
require "yaml"
require "rack"
require 'coffee-script'
require "haml"





$LOAD_PATH << './lib'
require "tree_struct"

$HOST="184.73.233.199" 
$Redis4=Redis.new(:password=>"redisreallysucks",:thread_safe=>true,:port=>6379,:host=>$HOST)
TextDb=4
$Redis4.select TextDb

$HOME="http://algviewer.heroku.com" #$HOME="http://0.0.0.0:4567"
IMAGE_CONTAINER="./image_container"
SVG_URL="http://#{$HOST}:8080"
puts ENV["URL"]

get "/edit_text/:form_name" do
  @form_name=params[:form_name]
  @text=($Redis4.get @form_name).to_s
  haml :text_form
end

get "/edit_text" do
  x=params[:form_name]
  redirect "/edit_text/#{x}"
end

get "/delete/:form_name" do
  @form_name=params[:form_name]
  $Redis4.del @form_name
  redirect "/"
end

get '/sass' do
  content_type 'text/css', :charset => 'utf-8'
  sass :styles
end

get '/export_all' do
  yaml_doc=[]
  content_type 'text/x-yaml', :charset => 'utf-8'
  $Redis4.keys.each do |x|
    yaml_doc<< ($Redis4.get x)
    yaml_doc<<"---"
  end
  yaml_doc.join "\n"
end

post '/upload_text' do
 form_text=params["form_content"]
 form_name=params["form_name"]
 $Redis4.set form_name,form_text
 redirect "/"
  #{}"content=#{params["form_content"]} and form name=#{params["form_name"]}"
  #params.to_s 
  
end


get '/coffee_test' do
  haml :coffee_test
end

get '/application' do
  content_type 'application/javascript'
  coffee :application
end

get "/" do
  puts env["HTTP_HOST"]
  @all_forms=$Redis4.keys.sort!
  haml :main
end

get '/view/:form_name' do
  form_name=params[:form_name]
  text=($Redis4.get form_name).to_s
  begin
    y=YAML.load text if text
  rescue
    puts "EEEEERRRRRROOOOORRRRR"
    return $stderr.puts $!.inspect
  end
  n=NodesEdges.new y
  nodes=n.get_nodes.to_json
  edges=n.get_edges.to_json
  url="#{SVG_URL}/nodes_edges/"
  puts url 
  Nestful.post url, :params=>{:edges=>edges,:nodes=>nodes}
  #{}"nodes are #{n.get_nodes}, <br> <br> <br> edges are#{n.get_edges}"
end





  

