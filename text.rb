require "nestful"
require "sinatra"
require "tempfile"
require "pathname"
require "redis"
require 'json/pure'
require "yaml"
require "rack"
require 'coffee-script'



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


__END__

@@ layout
\<!DOCTYPE html>
%html{:lang=>"en"}
  %head
    %script{:type=>"application/x-javascript",:src=>"http://ajax.googleapis.com/ajax/libs/jquery/1.4.0/jquery.min.js"}
    -# %link{:rel=>"stylesheet", :type=>"text/css", :href=> $HOME}
    %link{:rel=>"stylesheet", :href=>"/css/blueprint/screen.css", :type=>"text/css", :media=>"screen, projection"}
    %link{:rel=>"stylesheet", :href=>"/css/blueprint/print.css", :type=>"text/css", :media=>"print"}
    <!--[if lt IE 8]>
    %link{:rel=>"stylesheet", :type=>"text/css",:href=>"/css/blueprint/ie.css" ,:media=>"screen, projection"}
    <![endif]-->
    %link{:rel=>"stylesheet", :type=>"text/css",:href=>"/sass" ,:media=>"screen, projection"}
    %title AlgViewer
  %body
    .container
      %hr.space
      = yield
      %hr.space
      .span-24.last
        .small.prepend-16
          copyright &copy 
          %a{:href => 'http://www.carlobrunobifulco.com'} Carlo Bruno Bifulco
          2010


@@ coffee_test
%script{:type=>"application/x-javascript",:src=>"/application"}
 

@@ application
x=3+4
alert(x)

@@ styles
#edit
  width: 620px
  height: 500px
  padding: 5px
  font: 100% Monaco, "Courier New", Courier, monospace
  border: 2px solid
  border-color: #666
  color: Black
  width: 100%
  
a
  color: #3366CC
  &:hover
    color: #3366CC
    text-decoration: none
  &:focus,
  &:active
    outline: none
  &:visited

@@ main

%script{:type=>"application/x-javascript",:src=>"/jquery-ui-1.8.6.custom.min.js"}
%link{:rel=>"stylesheet", :type=>"text/css", :href=>"jquery-ui-1.8.6.custom.css"}

%div{:id=>"dialog", :title=>"Confirmation Required"}
  Are you sure you want to delete this graph?



.span-7.colborder
  %h6#view_view
    VIEW
  %h6
    %ul#hide_view
      -@all_forms.each  do |x|
        %li
          %a{:href=>"/view/#{x}"}=x 
.span-8
  %h6#view_edit 
    EDIT
  %ul#hide_edit
    -@all_forms.each  do |x|
      %li
        %a{:href=>"/edit_text/#{x}"}=x
.span-8.last
  %h6#view_delete 
    DELETE
  %ul#hide_delete
    -@all_forms.each  do |x|
      %li
        %a.confirmLink{:href=>"/delete/#{x}"}=x
.span-24
.span-7
  %h6
    %form{:action=>"/edit_text",:method=>"get"}
      NEW ALG: 
      %input{:type=>"text",:name=>"form_name",:cols=>"30"} 
      %input{:type=>"submit",:value=>"Send"}

:javascript 

  $(document).ready(function(){

    $("#dialog").dialog({
         autoOpen: false,
         modal: true
       });

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


  $(".confirmLink").click(function(e) {
     e.preventDefault();
     var targetUrl = $(this).attr("href");

     $("#dialog").dialog({
       buttons : {
         "Confirm" : function() {
           window.location.href = targetUrl;
         },
         "Cancel" : function() {
           $(this).dialog("close");
         }
       }
     });

     $("#dialog").dialog("open");
   });
  }); 





@@ text_form
%script{:type=>"application/x-javascript",:src=>"/jquery-fieldselection.js"}
%script{:type=>"application/x-javascript",:src=>"/code-edit.js"}

%h1 
  %p=@form_name
%div#links.info
  %p 
    Show example
%div#hide.notice
  %p 
    Always leave a space after the Yaml's "-" and the ":".
  %p
    Wrap/escape : in  ":" or in ':'.
  %p
    Respect the "-" followed by " - pattern, e.g.:
  %p
    Specimen

%form{:action=>"/upload_text",:method=>"post"}
  %textarea{:class=>"autoindent",:id=>"edit",:name=>"form_content",:rows=>"40",:cols=>"80",:lang=>"en", :style=>"direction: ltr;",:wrap=>"SOFT"}=@text
  %input{:type=>"hidden",:name=>"form_name",:value=>@form_name}
  %input{:type=>"submit",:value=>"Send"}
    
:javascript 
  $(document).ready(function(){
  $("#hide").hide();
  $("#links").click(function(){
    $("#hide").toggle();
    $("#links").html("Close example");
  });
  });
  
  

