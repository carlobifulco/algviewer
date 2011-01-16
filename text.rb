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
require "redis-namespace"


#SVG SERVER SETUP
#----------------
$HOST="184.73.233.199" 
# location of svg REST service. localhost if test 
if ARGV.length !=0
  test=true if ARGV[0]=="test"
else
  test=false
end

# choosing local server if test parameter, otherwise go to ec2
if not test
  SVG_URL="http://#{$HOST}:8080"
  puts "connecting to EC2 server at #{SVG_URL}"
else
  SVG_URL="http://0.0.0.0:8080"
  puts "connecting to test svg server at #{SVG_URL}"
end


my_directory=File.dirname(File.expand_path(__FILE__))
puts my_directory


set :haml, {:format => :html5 }
enable :sessions

# lib for the generation of the DOT Files
$LOAD_PATH << File.join(my_directory,'/lib')
require "tree_struct"



# AWS Redis and Svg generator server home
$Redis4=Redis.new(:password=>"redisreallysucks",:thread_safe=>true,:port=>6379,:host=>$HOST)
#where the text forms reside
TextDb=4 
$Redis4.select TextDb
$r=false

$HOME="http://algviewer.heroku.com" #$HOME="http://0.0.0.0:4567"
IMAGE_CONTAINER="./image_container"
Dir.mkdir IMAGE_CONTAINER unless Dir.exists? IMAGE_CONTAINER



puts ENV["URL"]


#Text Edit
#------------

#edit text form , both as a url and as a get? request
get "/edit_text/:form_name" do
  @form_name=params[:form_name]
  
  @text=($r.get @form_name).to_s
  haml :text_form
end

get "/edit_text" do
  x=params[:form_name]
  redirect "/edit_text/#{x}"
end

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
  puts env["HTTP_HOST"]
  if $r
    @all_forms=$r.keys.sort!
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


# text from redis stored form
# called 
get '/view/:form_name' do
  form_name=params[:form_name]
  text=($r.get form_name).to_s
  # eliminate colomns in the rendering
  text=text_cleanup(text)
  y=yaml_load(text)
  begin
    r=rest_call y
    @svg=r["svg"]
    @png=r["png"]
    @pdf=r["pdf"]
    @dot=r["dot"]
    puts @pdf
    haml :view
  rescue ":Error"
    puts "EEEEERRRRRROOOOORRRRR"
    return $stderr.puts $!.inspect
  end
end


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

# Colors
#--------

post '/store_graph_colors' do
  colors=JSON.parse(params[:colors])
  graph_name=params[:graph_name]
  colors_hash_name="#{session['user']}___colors"
  $r.hset colors_hash_name, graph_name, colors.to_json
  puts "COLORS: #{colors} GRAPH NAME: #{graph_name} "
end


post '/get_graph_colors' do
  graph_name=params[:graph_name]
  colors_hash_name="#{session['user']}___colors"
  colors=$r.hget colors_hash_name, graph_name
  puts "REQUESTD FOR COLORS #{colors}"
  return colors
end




  

