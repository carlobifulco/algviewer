require "nestful"
require "sinatra"
require "tempfile"
require "pathname"
require "redis"
require 'json'
require "yaml"
require "rack"
require "haml"
require "redis-namespace"


#HAML Setup
#-----------
set :haml, {:format => :html5 }


#SVG SERVER SETUP
#----------------
# redis server

puts ARGV
puts "SETTINGS port #{settings.port}" 

# location of svg REST service and REDIS. localhost if test 
if ARGV.length !=0 and  ARGV[0]=="test"
  # choosing local server if test parameter, otherwise go to ec2
  $HOST="0.0.0.0"
  puts "connecting to test svg server at http://#{$HOST}:#{settings.port}"
else
  $HOST="184.73.233.199" 
  puts "connecting to EC2 server at http://#{$HOST}:#{settings.port}"
end

SVG_URL="http://#{$HOST}:#{settings.port}"

# libs for the generation of the DOT Files
my_directory=File.dirname(File.expand_path(__FILE__))
$LOAD_PATH << File.join(my_directory,'/lib')
$LOAD_PATH <<my_directory
require "tree_struct"
require "dot_generator"


#REDIS RESERVED KEYS
#--------------------
# these keys will be removed from a keys_all redis command
$redis_reserved={:colors=>"^___colors",:node_color=>"^___nodecolors"}

#SINATRA SETUPS
#----------------
set :root, File.dirname(__FILE__)
set :haml, {:format => :html5 }
# Keeping coffee, compiled JS and haml files in the same directory
set :views, Proc.new { File.join(root, "public/views") }
enable :sessions




# REDIS 4 contains all text of algs; stored with user namespace
#---------------------------------------------------------------


# AWS Redis and Svg generator server home
$Redis4=Redis.new(:password=>"redisreallysucks",:thread_safe=>true,:port=>6379,:host=>$HOST)
#where the text forms reside
TextDb=4 
$Redis4.select TextDb
$r=false



#IMAGES
#-------
IMAGE_CONTAINER="./image_container"
Dir.mkdir IMAGE_CONTAINER unless Dir.exists? IMAGE_CONTAINER





#Delete
#-------

#delete text form
get "/delete/:form_name" do
  @form_name=params[:form_name]
  $r.del @form_name
  redirect "/"
end

# CSS
#-----
# css as sass
get '/sass' do
  content_type 'text/css', :charset => 'utf-8'
  sass :styles
end


# exports all docs as a big Yaml text file
get '/export_all' do
  yaml_doc=[]
  content_type 'text/x-yaml', :charset => 'utf-8'
  $r.keys.each do |x|
    yaml_doc<< ($r.get x)
    yaml_doc<<"---"
  end
  yaml_doc.join "\n"
end


# uploading a textform; back to main page unless request via ajax in which case it will return true
 #{}"content=#{params["form_content"]} and form name=#{params["form_name"]}"
post '/upload_text' do
 form_text=params["form_content"]
 form_name=params["form_name"]
 $r.set form_name,form_text
 return true if params.has_key? "type"
 redirect "/" 
end


#Password Login
#---------------

# ajax called. receives username and password and checks the on code
# also sets user specific namespace for redis connection!!!
post '/check_user' do
  puts params
  user=params["user"]
  password=params["password"]
  users=["guest","carlobifulco", "nicole", "tester", "master"]
  passwords=["guest","bifulcocarlo", "nicole", "tester", "master"]
  if (users.include?(user) and passwords.include?(password))
    session["user"]=user
    puts session["user"]
    #rebinds redis to an user specific namespace
    if session["user"] !="master"
      $r= Redis::Namespace.new(session["user"], :redis =>$Redis4) 
    else
      # user master has no namespace restrictions
      $r=$Redis4 
    end
    
    #$Redis4=Redis::Namespace.new(:password=>"redisreallysucks",:thread_safe=>true,:port=>6379,:host=>$HOST,:ns=>user) 
    return "OK".to_json

  else
    return false.to_json
  end
end



get "/" do
  # This checks auth and stores username in session
  username=session["user"]
  if $r
    @all_forms=$r.keys.sort!
    final_forms=[]
    @all_forms.each do |x|
      puts  "^#{x.split('^')[1]}"
      if $redis_reserved.values.include? "^#{x.split('^')[1]}"
        next
      else
        final_forms<<x
      end 
    end
    @all_forms=final_forms
  else
    @all_forms=$Redis4.keys.sort!
  end
  haml :main
end



# Graphic rendering of the boxes
#-------------------------------


# Text2Box created tuple list with text at 0 and indent at 1
# this is then used by coffee to create the boxes and to appropriately
# indent them
def text_indent(form_name)
  text=($r.get form_name).to_s
  if text==""
    return false
  else
    t=Text2Box.new text
    return t.get_text_indent()
  end
end




# just serving the page
get "/graphic_edit/:form_name" do
  haml :coffee_test
end


# for ajax called for rendering of the boxes
#create array of tuples with e.g. [[" Colon Ca", 0], [" Kras Codons 12 and 13 exon 2 (40% of cases)", 1], ...
# This in then rendered by coffee into boxes
get '/ajax_text_indent/:form_name' do
  form_name=params[:form_name]
  text_indent=text_indent(form_name)
  return text_indent.to_json
end


get '/test' do
  haml :test
end


#DOT ENGINE
#-----------

#Call to dot engine at SVG_URL default
#yaml load and rest call; returns dictionary response
#colors are shipped along, if they are there
def rest_call(y,colors=false)
  n=NodesEdges.new y
  nodes=n.get_nodes.to_json
  edges=n.get_edges.to_json
  #calls nodes_edges on svg_genrator
  url="#{SVG_URL}/nodes_edges/"
  puts url 
  if not colors
    r=JSON.parse(Nestful.post url, :params=>{:edges=>edges,:nodes=>nodes})
  else
    r=JSON.parse(Nestful.post url, :params=>{:edges=>edges,:nodes=>nodes,:colors=>colors})
  end
  puts r
  r
end

# cleanup of text before yaml load
def text_cleanup(text)
  text.gsub!(":","")
  # this should eliminate a final - in an alg that is getting built
  # by splitting lines and reuniting them except for the last if it is a lone"-"
  # this is repeated twice since the empty - could be followed by a \n
  puts "INITIAL #{text}"
  text=text.strip()
  text=text.split("\n")[0..-2].join("\n") if text.split("\n")[-1].strip()=="-"
  text=text.strip()
  new_text=[]
  # eliminates ints and floats by wrapping them in quotes. The tree_struc alg wants only arrays or strings
  text.split("\n").each do |x| 
    x.rstrip!
    # if "- 222.333" m[1] is 222 and m[2] is .333
    m=x.match /-\s(\d+)(\.?\d+)?$/
    if m
      new_text<<x.gsub(m[1],'"'+m[1]+'"') if not m[2]
      new_text<<x.gsub(m[1]+m[2],'"'+m[1]+m[2]+'"') if m[2]
    else
      new_text<<x
    end
  end
  text=new_text.join("\n")
  puts "TEXT:#{text}"
  puts "----------"
  return text
end

# loads yaml text
def yaml_load(text)
  begin
    y=YAML.load text if text
    puts "YAML: #{y}"
    return y
  rescue ":Error"
    puts "EEEEERRRRRROOOOORRRRR"
    return $stderr.puts $!.inspect
  end
end


# all is handled by json calls from JS
# when page is loaded JS finds out who the user is and the algname 
# and calls  
get '/view/:form_name' do
  form_name=params[:form_name]
  haml :view
end



# Graphic edit
#---------------


# text directly
# used by graphic edit
# also by all AJAX calls
# Also getting colors. Still need to send them to svg_generator...
post '/graphic_edit_view' do
  text=params[:text]
  colors=params[:hex]
  puts "colorts #{colors}"
  text=text_cleanup(text)
  y=yaml_load(text)
  begin
    r=rest_call(y,colors)
    return r.to_json
  rescue ":Error"
    puts "EEEEERRRRRROOOOORRRRR"
    return $stderr.puts $!.inspect
  end
end

# Colors For Boxes Paintingnest
#---------------------------
# for boxes painting and NOT for node rendering
# data structure is just a list of rgb values

post '/store_graph_colors' do
  colors=JSON.parse(params[:colors])
  graph_name=params[:graph_name]
  colors_hash_name="#{session['user']}#{$redis_reserved[:colors]}"
  $r.hset colors_hash_name, graph_name, colors.to_json
  puts "COLORS: #{colors} GRAPH NAME: #{graph_name} "
end



#colors stored in redis in a {user___colors{graphname:xxx}} structure
post '/get_graph_colors' do
  graph_name=params[:graph_name]
  colors_hash_name="#{session['user']}#{$redis_reserved[:colors]}"
  colors=$r.hget colors_hash_name, graph_name
  puts "REQUESTD FOR COLORS #{colors}"
  return colors
end




# REST form content interface
#----------------------------
#doctest: yaml rest
#=> "a"
#>> Nestful.post("http://0.0.0.0:4567/yaml/test",:params=>{:user_name=>"carlo", :content=>text})
#=> "true"
#>> Nestful.get("http://0.0.0.0:4567/yaml/test",:params=>{:user_name=>"carlo"})
#=> "\"a\""
 
 
def get_yaml  user_name,form_name
  r= Redis::Namespace.new(user_name, :redis =>$Redis4) 
   #yaml
   text=(r.get form_name).to_s
   puts "form text = #{text}"
   puts text.class
   # eliminate colomns in the rendering
   if text and text != ""
     text=text_cleanup(text)
     y=yaml_load(text)
     return y
   else
     return false
   end
end


get '/yaml/:form_name' do
  content_type :json
  form_name=params[:form_name]
  user_name=params[:user_name]
  (get_yaml(user_name,form_name)).to_json
end


post '/yaml/:form_name' do
  content_type :json
  puts params
  form_name=params[:form_name]
  user_name=params[:user_name]
  content=params[:content]
  r= Redis::Namespace.new(user_name, :redis =>$Redis4) 
  r.set form_name,content
  return true.to_json
end

get '/text/:form_name' do
  content_type :json
  form_name=params[:form_name]
  user_name=params[:user_name]
  r= Redis::Namespace.new(user_name, :redis =>$Redis4) 
  text=(r.get form_name).to_s
  return text.to_json
end

#save test only if loadable, else error
#also, returns urls
post '/text/:form_name' do
  content_type :json
  form_name=params[:form_name]
  user_name=params[:user_name]
  content=params[:content]
  r= Redis::Namespace.new(user_name, :redis =>$Redis4) 
  if content and content != ""
    content=text_cleanup(content)
    yaml=yaml_load(content)
  else
    raise "ERRRROROOR"
  end
  r.set form_name,content
  colors=get_color user_name, form_name
  get_urls(yaml,colors)
end

#Colors for Nodes
#----------------
#doctest: colors rest
#>> Nestful.post("http://0.0.0.0:4567/nodes_colors/test",:params=>{:user_name=>"carlo", :colors=>{2=>2}})
#=> "true"
#>> ;
#=> "\"{\\\"2\\\"=>\\\"2\\\"}\""


def get_color user_name, graph_name
  node_color_hash="#{user_name}#{$redis_reserved[:node_color]}"
  puts node_color_hash
  puts graph_name
  r= Redis::Namespace.new(user_name, :redis =>$Redis4) 
  colors=r.hget node_color_hash,graph_name
  if colors
    return colors
  else
    return {}.to_json
  end
end

def get_urls yaml,colors
  graph=Graph.new
  nodes_edges=NodesEdges.new yaml
  graph.add_nodes(nodes_edges.get_nodes(),colors)
  graph.add_edges(nodes_edges.get_edges())
  {:svg=>graph.get_svg(),:pdf=>graph.get_pdf(),:png=>graph.get_png(),:dot=>graph.get_dot()}.to_json
end


post '/nodes_colors/:graph_name' do
  content_type :json
  graph_name=params[:graph_name]
  colors=params[:colors]
  user_name=params[:user_name]
  #name_space storage
  node_color_hash="#{user_name}#{$redis_reserved[:node_color]}"
  puts node_color_hash
  puts colors
  r= Redis::Namespace.new(user_name, :redis =>$Redis4) 
  r.hset node_color_hash,graph_name,colors
  return true.to_json
end

get '/nodes_colors/:graph_name' do
  content_type :json
  graph_name=params[:graph_name]
  user_name=params[:user_name]
  (get_color user_name,graph_name).to_json
  #name_space storage
end


get '/show_graph/:graph_name' do
  content_type :json
  graph_name=params["graph_name"]
  user_name=params["user_name"]
  yaml=get_yaml(user_name,graph_name)
  colors=get_color user_name, graph_name
  get_urls(yaml,colors)
end


# get all URLS; needs colors_hash and yaml_text as params
get '/graph' do
  #	$.get("/graph",{"colors_hash":window.colors_hash,"yaml_text":window.yaml_text, type:"ajax"},(graph_urls)->alert(graph_urls))
  colors_hash=JSON.parse(params["colors_hash"]) 
  yaml_text=JSON.parse(params["yaml_text"])
  get_urls(yaml_text,colors_hash)
end


get '/alg_names/:user_name' do
  r= Redis::Namespace.new(params["user_name"], :redis =>$Redis4) 
  all_forms=r.keys.sort!
  final_forms=[]
  all_forms.each do |x|
    puts  "^#{x.split('^')[1]}"
    if $redis_reserved.values.include? "^#{x.split('^')[1]}"
      next
    else
      final_forms<<x
    end 
  end
  final_forms.to_json
end



## REST Text Edit
#------------

#edit text form , both as a url and as a get? request
get "/edit_text/:form_name" do
  haml :text_form
end

get "/edit_text" do
  x=params[:form_name]
  redirect "/edit_text/#{x}"
end

  

