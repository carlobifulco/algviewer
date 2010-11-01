require "nestful"
require "sinatra"
require "tempfile"
require "pathname"
require "redis"
require 'json/pure'
require "yaml"
require "rack"

$LOAD_PATH << './lib'
require "tree_struct"

$HOST="184.73.233.199" 
$Redis4=Redis.new(:password=>"redisreallysucks",:thread_safe=>true,:port=>6379,:host=>$HOST)
TextDb=4
$Redis4.select TextDb

$HOME="http://algviewer.heroku.com" #$HOME="http://0.0.0.0:4567"
IMAGE_CONTAINER="./image_container"
SVG_URL="http://#{$HOST}:8080"

get "/edit_text/:form_name" do
  @form_name=params[:form_name]
  @text=($Redis4.get @form_name).to_s
  haml :text_form
end

get "/edit_text" do
  x=params[:form_name]
  redirect "#{$HOME}/edit_text/#{x}"
end

get "/delete/:form_name" do
  @form_name=params[:form_name]
  $Redis4.del @form_name
  redirect "/"
end


post '/upload_text' do
 form_text=params["form_content"]
 form_name=params["form_name"]
 $Redis4.set form_name,form_text
 redirect "/"
  #{}"content=#{params["form_content"]} and form name=#{params["form_name"]}"
  #params.to_s 
  
end

get "/" do
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


__END__

@@ layout
\<!DOCTYPE html>
%html{:lang=>"en"}
  %head
    %script{:type=>"application/x-javascript",:src=>"http://ajax.googleapis.com/ajax/libs/jquery/1.4.0/jquery.min.js"}
    / %script{:type=>"application/x-javascript",:src=>"css/jquery.svg.js"}
    /    %script{:type=>"application/x-javascript",:src=>"css/jquery.svgdom.js"}
    -# %link{:rel=>"stylesheet", :type=>"text/css", :href=> $HOME}
    %title 
  %body
    = yield

@@ main

%h6#view_view
 VIEW
%h6
 %ul#hide_view
  -@all_forms.each  do |x|
   %li
    %a{:href=>"#{$HOME}/view/#{x}"}=x 

%h6#view_edit 
 EDIT
 %ul#hide_edit
  -@all_forms.each  do |x|
   %li
    %a{:href=>"#{$HOME}/edit_text/#{x}"}=x

%h6#view_delete 
 DELETE
 %ul#hide_delete
  -@all_forms.each  do |x|
   %li
    %a{:href=>"#{$HOME}/delete/#{x}"}=x

%h6
 %form{:action=>"/edit_text",:method=>"get"}
  NEW NAME HERE: 
  %input{:type=>"text",:id=>"edit",:name=>"form_name",:cols=>"30"} 
  %input{:type=>"submit",:value=>"Send"}

:javascript 
  $(document).ready(function(){
  
  $("#view_view").click(function(){
    $("#hide_view").toggle();
  });
  
  $("#hide_edit").hide();
  $("#view_edit").click(function(){
    $("#hide_edit").toggle();
  });
  
  $("#hide_delete").hide();
  $("#view_delete").click(function(){
    $("#hide_delete").toggle();
  });
  
  
  }); 

  
    
=@all_forms_edit.to_s
/ %ul
/   - @all_forms.each do |x|
/     %li
/       %a{:href=>x@result_png}



@@ text_form
%h1 
  %p=@form_name
%div#links
  %p 
    Show example
%div#hide
  %p 
    Always leave a space after the Yaml's "-" and the ":".
  %p
    Wrap/escape : in  ":" or in ':'.
  %p
    Respect the "-" followed by " - pattern, e.g.:
  %p
    Specimen
%form{:action=>"/upload_text",:method=>"post"}
  %textarea{:id=>"edit",:name=>"form_content",:rows=>"40",:cols=>"30",:lang=>"en", :style=>"direction: ltr;",:wrap=>"SOFT"}=@text
  %input{:type=>"hidden",:name=>"form_name",:value=>@form_name}
  %input{:type=>"submit",:value=>"Send"}
    
:css
  textarea {
  font: 70% Monaco, "Courier New", Courier, monospace;
  border: 1px solid #ddd;
  border-color:#666 #ddd #ddd #666;
  color: Black;
  width: 100%;
  }  

:javascript 
  $(document).ready(function(){
  $("#hide").hide();
  $("#links").click(function(){
    $("#hide").toggle();
    $("#links").html("Close example");
  });
  });
  
  

