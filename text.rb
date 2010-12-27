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





my_directory=File.dirname(File.expand_path(__FILE__))
puts my_directory


set :haml, {:format => :html5 }
enable :sessions


$LOAD_PATH << File.join(my_directory,'/lib')
require "tree_struct"



# AWS Redis and Svg generator server home
$HOST="184.73.233.199" 
$Redis4=Redis.new(:password=>"redisreallysucks",:thread_safe=>true,:port=>6379,:host=>$HOST)
#where the text forms reside
TextDb=4 
$Redis4.select TextDb

$HOME="http://algviewer.heroku.com" #$HOME="http://0.0.0.0:4567"
IMAGE_CONTAINER="./image_container"
Dir.mkdir IMAGE_CONTAINER unless Dir.exists? IMAGE_CONTAINER
SVG_URL="http://#{$HOST}:8080"
puts ENV["URL"]

def unique_file_name file_name
  file_name=File.basename file_name
  file_name=file_name.gsub("."+file_name.split(".")[-1],"")
  # will need ot be fixed
  t=Time.now.to_s.split.join("_")
  File.join(IMAGE_CONTAINER,(t+"_"+file_name))
end



post '/upload' do

  puts "CALLED /upload"
  puts params
  
  unless params[:file] && (tmpfile = params[:file][:tempfile]) && (name = params[:file][:filename])
    puts "No file selected"
    redirect "/"
  end

  file_name=unique_file_name(name)
  fh=File.open(file_name,"w")
  fh.write(tmpfile.read)
  fh.close
  puts file_name
  redirect "/"  
end


#edit text form , both as a url and as a get? request
get "/edit_text/:form_name" do
  @form_name=params[:form_name]
  @text=($Redis4.get @form_name).to_s
  haml :text_form
end

get "/edit_text" do
  x=params[:form_name]
  redirect "/edit_text/#{x}"
end


#delete text form
get "/delete/:form_name" do
  @form_name=params[:form_name]
  $Redis4.del @form_name
  redirect "/"
end


# css as sass
get '/sass' do
  content_type 'text/css', :charset => 'utf-8'
  sass :styles
end


# exports all docs as a big Yaml text file
get '/export_all' do
  yaml_doc=[]
  content_type 'text/x-yaml', :charset => 'utf-8'
  $Redis4.keys.each do |x|
    yaml_doc<< ($Redis4.get x)
    yaml_doc<<"---"
  end
  yaml_doc.join "\n"
end


# uploading a textform; back to main page unless request via ajax in which case it will return true
 #{}"content=#{params["form_content"]} and form name=#{params["form_name"]}"
post '/upload_text' do
 form_text=params["form_content"]
 form_name=params["form_name"]
 $Redis4.set form_name,form_text
 return true if params.has_key? "type"
 redirect "/" 
end

# the playground
get '/coffee_test' do
  haml :coffee_test
end


# post '/coffee_test' do
#   form_content=params[:graphic_form_content]
#   haml :coffee_test
# end

#never got this to work
get '/application' do
  content_type 'application/javascript'
  coffee :application
end

post '/check_user' do
  puts params
  user=params["user"]
  password=params["password"]
  users=["guest","carlobifulco"]
  passwords=["guest","bifulcocarlo"]
  if (users.include?(user) and passwords.include?(password))
    session["user"]=user
    puts session["user"]
    return "OK".to_json
  else
    return false.to_json
  end
end



get "/" do
  # This checks auth and stores username in session
  username=session["user"]
  puts env["HTTP_HOST"]
  @all_forms=$Redis4.keys.sort!
  haml :main

end


#### still defective; problem with rendering of multiple yaml lines, ok with 2, 
# split newline --inline newlines in need of fix
# remove empty lines starting with -, empty lines
# get offset by indentation of first line 
# then create array of tuples with e.g. [[" Colon Ca", 0], [" Kras Codons 12 and 13 exon 2 (40% of cases)", 1], ...
get "/graphic_edit/:form_name" do
  @form_name=params[:form_name]
  text=($Redis4.get @form_name).to_s
  #for new forms just returns empty content
  if text==""
    @text_indent=""
    return haml :coffee_test
  end
  puts "1111"
  puts text
  text=text.split("\n")
  fused_lines=[]
  text.each do |x|  
     if x.lstrip()[0] !="-" and fused_lines[-1]
       fused_lines[-1]=fused_lines[-1].strip() +x 
     else 
       fused_lines<<x 
     end
   end
  text=fused_lines
  puts text
  (text.collect! {|t| t.rstrip}).select! {|t| (t !="-" and t.strip() !="" and t.strip() !="-")}
  offset=text[1].index "-"
  offset=2 if offset==0
  puts "OFFSET=#{offset}"
  print text
  puts text
  boxes_indent=text.collect {|x| (x.index("-")/offset)}
  text.collect! {|x| x.delete "-"}
  puts boxes_indent.to_json
  @text_indent=(text.zip boxes_indent).to_json
  url="/coffee_test"
  haml :coffee_test
    #@text.select! {|x| x.delete! "-"}
  #haml :graphic_edit
end


#### The next two should be one function; 
#### the only difference among them is that one gets the text from the redis form, 
#### while the other gets it directly


#yaml load and rest call; returns dictionary response
def rest_call(y)
  n=NodesEdges.new y
  nodes=n.get_nodes.to_json
  edges=n.get_edges.to_json
  url="#{SVG_URL}/nodes_edges/"
  puts url 
  r=JSON.parse(Nestful.post url, :params=>{:edges=>edges,:nodes=>nodes})
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
  text=($Redis4.get form_name).to_s
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
post '/graphic_edit_view' do
  text=params[:text]
  text=text_cleanup(text)
  y=yaml_load(text)
  begin
    r=rest_call y
    return r.to_json
  rescue ":Error"
    puts "EEEEERRRRRROOOOORRRRR"
    return $stderr.puts $!.inspect
  end
end





  

