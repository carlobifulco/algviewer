require "sinatra"
require 'json/pure'
require "graphviz"
require "hpricot"
require "haml"
require "redis"
require 'digest/md5'
require "sass"
require "rinruby"
require "tempfile"
require "pathname"

$redis=Redis.new
$HOME="http://184.73.233.199:8080"

set :haml, {:format => :html5 }

def para text
  a=text.split
  f=[]

  a.each do |x|
      f << x
      if (f.join(" ").split "\n")[-1].length/7 > 1
      
      
        f<< "\n"
      elsif x.index "*"
        f<< "\n"
      end
  end
  f.join " "
end


class Plot
  def initialize data_list
    @data_list=data_list
  end
  
  def get_file_name
    @temp_file_name
  end
  
  def plot_png
    R.plot_data=@data_list
    @temp_file_name=(Tempfile.new "a").path
    R.file_name=@temp_file_name
    R.eval("png(file=file_name)")
    R.eval("plot(plot_data)")
    R.eval("dev.off()")
    png_doc=File.new(R.file_name,"r").read 
    redis_key=(Pathname.new(R.file_name).split)[1]
  	$redis.set redis_key, png_doc
    $redis.expire redis_key, 3000
    "#{$HOME}/graph_png/#{redis_key}"
  end
    
  def plot_pdf
    R.plot_data=@data_list
    @temp_file_name=(Tempfile.new "a").path
    R.file_name=@temp_file_name
    R.eval("pdf(file=file_name)")
    R.eval("plot(plot_data)")
    R.eval("dev.off()")
    pdf_doc=File.new(R.file_name,"r").read 
    redis_key=(Pathname.new(R.file_name).split)[1]
  	$redis.set redis_key, pdf_doc
    $redis.expire redis_key, 3000
    "#{$HOME}/graph_pdf/#{redis_key}"
  end
end

module JavaScript
  def get_javascript
    return '
    <script type="text/javascript" charset="utf-8">
    	function test (e) {
    		alert(e.id);
    		return e
    		// body...
    	}
    </script>
    '
  end
  
  def clean_svg doc #hrpicot doc tree
    d= doc.at("svg")
    d.remove_attribute "xmlns"
    d.remove_attribute "xmlns:xlink"
    d.remove_attribute "viewbox"
    #d.remove_attribute "width"
    #d.remove_attribute "height"
    d
  end
end

class Graph
  
  include JavaScript
  def initialize
    @g=GraphViz.new(:G,:type=>:digraph,:rankdir=>"TB",:center=>"true")
    @g.node[:fontsize] = "14"
    @g.node[:shape]    = "box"
    @g.node[:color]    = "#ddaa66"
    @g.node[:style]    = "filled"
    @g.node[:shape]    = "box"
    @g.node[:penwidth] = "1"
    @g.node[:fillcolor]= "#ffeecc"
    @g.node[:fontcolor]= "#775500"
    @g.node[:margin]   = "0.0"
    
    # @g.edge[:color]    = "#999999"
    # @g.edge[:weight]   = "1"
    # @g.edge[:fontsize] = "6"
    # @g.edge[:fontcolor]= "#444444"
    # @g.edge[:fontname] = "Verdana"
    # @g.edge[:dir]      = "forward"
    # @g.edge[:arrowsize]= "0.5"
    
    @redis=Redis.new
  end
  
  def add_nodes(nodes)
    nodes.each do |node|
       add_node(node)
     end
  end
  
  def add_edges(edges_lists)
    
    edges_lists.each do |edge_list|
      edge_list.each do |edge|
        add_edge(edge)  
      end
    end  
  end
  
  def print_edges(edges_lists)
    puts edges_lists
      edges_lists.each do |edge_list|
        edge_list.each do |edge|
          puts "1 #{edge[0]} 2#{edge[1]}"  
        end
      end  
    end
    
  
  def add_node(node)
    begin
    new_node=@g.add_node(node)
   # text='<<TABLE BORDER="0" CELLBORDER="0" CELLSPACING="0" CELLPADDING="0"><TR><TD FIXEDSIZE="TRUE" WIDTH="300"  ALIGN="CENTER" HEIGHT="60">'+node+'</TD></TR></TABLE>>'
    new_node[:label]=para node
    
    
     puts "node added #{node}"
    rescue
   "failed"
 end
  end
  
  def add_edge(edge_tuple)
   
    puts "trying to added edge #{edge_tuple[0]} to #{edge_tuple[1]}"
    @g.add_edge(edge_tuple[0],edge_tuple[1])
    puts "edge added #{edge_tuple[0]} to #{edge_tuple[1]}"
    
  end
  
  def test_image
   @g.output(:svg=>"test.svg")
  end
  
  def get_pdf 
    pdf_doc=@g.output(:pdf=>String)
	@pdf_md5=Digest::MD5.hexdigest(pdf_doc)
	@redis.set @pdf_md5, pdf_doc
    @redis.expire @pdf_md5, 3000
    "#{$HOME}/graph_pdf/#{@pdf_md5}"
  end
  
   def get_png 
    doc=@g.output(:png=>String)
	@png_md5=Digest::MD5.hexdigest(doc)
	@redis.set @png_md5, doc
    @redis.expire @png_md5, 3000
    "#{$HOME}/graph_png/#{@png_md5}"
  end
  
  def get_svg
    svg_doc=@g.output(:svg=>String)
    d=clean_svg(Hpricot.parse(svg_doc))
    (d.search("g")[1..-1]).each  do |graph|
      graph.set_attribute "onclick", "test(this)"
    end
    @result="<!DOCTYPE html>
    <html>
      <body>"
    @result=d.to_s
    @result+=get_javascript
    @result+="  </body>
    </html>"
    @svg_md5=Digest::MD5.hexdigest(@result)
    @redis.set @svg_md5, @result
    @redis.expire @svg_md5, 3000
    "#{$HOME}/graph/#{@svg_md5}"
  end
end

get '/graph_pdf/:pdf_md5' do
  content_type "application/pdf"
  $redis.get params[:pdf_md5]
end

get '/graph/:svg_md5' do
  #content_type "image/svg+xml"
  $redis.get params[:svg_md5]
end

get '/graph_png/:png_md5' do
  content_type "image/png"
  $redis.get params[:png_md5]
end

get '/plot_pdf/:pdf_md5' do
  content_type "image/png"
  $redis.get params[:pdf_md5]
end


# get '/nodes/' do
#   nodes=JSON.parse params[:nodes]
#   puts nodes
#   nodes.each do |node|
#     puts node + " ANOTHER ENTRY"
#   end
#   " #{params.to_s} and here is q:#{params[:nodes]}"
#   
# end

get '/' do
  haml :index
end

post '/nodes_edges/' do
  graph=Graph.new
  nodes=JSON.parse params[:nodes]
  edges=JSON.parse params[:edges]
  puts " NODES " + nodes.to_s
  puts "EDGES " + edges.to_s
  graph.add_nodes(nodes)
  graph.add_edges(edges)
  @result=graph.get_svg
  @result_pdf=graph.get_pdf
  @result_png=graph.get_png
  haml :svg
end



get '/data_list' do
  #data passed as csv eg 1,2,3,4,5,6,7
  data_list=(params[:data_list])
  if data_list.include? ","
    data_list=data_list.split(",")
  else
    data_list=data_list.split()
  end
  puts data_list
  plotter=Plot.new(data_list)
  @pdf_url=plotter.plot_pdf()
  @png_url=plotter.plot_png()
  puts plotter.get_file_name
  haml :plot
end

  
  
# get '/stylesheet' do
#   content_type 'text/css', :charset => 'utf-8'
#   sass :styles
# end
  
  #puts graph.get_svg
  #{}"#{result.to_s}"
  

  

# post '/nodes/' do
#   graph=Graph.new
#   nodes=JSON.parse params[:nodes]
#   puts nodes
#   graph.add_nodes(nodes)
#   graph.test_image
#   " #{params.to_s} and here is q:#{params[:nodes]}"
#   
# end
# 
# post '/edges/' do
#    edges=JSON.parse params[:edges]
#    puts " #{params.to_s} and here are the edges q #{edges}"
#    graph=Graph.new
#    graph.add_edges(edges)
#    "HELLP"
# end

# <object data="foo.svgz" type="image/svg+xml"
#     width="400" height="300">
#   <embed src="foo.svgz" type="image/svg+xml"
#       width="400" height="300"
#       pluginspage="http://www.adobe.com/svg/viewer/install/" />
# </object>


# <object type="image/svg+xml" width="476" height="525" data="map.svg">
#     <img src="map.png" width="476" height="525" />
# </object>
#  if I use a PNG as fallback, 

__END__

@@ layout
\<!DOCTYPE html>
%html{:lang=>"en"}
  %head
    %script{:type=>"application/x-javascript",:src=>"http://ajax.googleapis.com/ajax/libs/jquery/1.4.0/jquery.min.js"}
    %script{:type=>"application/x-javascript",:src=>"css/jquery.svg.js"}
    %script{:type=>"application/x-javascript",:src=>"css/jquery.svgdom.js"}
    -# %link{:rel=>"stylesheet", :type=>"text/css", :href=> $HOME}
    %title 
  %body
    = yield

@@ index
%p 
  HELLO WORLD
%div
  %form{:action=>"data_list", :method=>"get"}
    %input{:name=>"data_list", :type=>"text"}
    %input{:type=>"submit", :class=>"butt"}

@@ svg
%header
  %div
    %a{:href=>@result}
      %p
        LINK TO GRAPH_SVG
    %a{:href=>@result_pdf}
      %p
        LINK TO GRAPH PDF	
    %a{:href=>@result_png}
      %p
        LINK TO GRAPH PNG	
  GRAPH RESULT
%div
  %object{:type=>"image/svg+xml", :id=>"svg", :data=>@result,:width=>"2000", :height=>"2000"}

@@ plot
%header
  %div
    %a{:href=>@pdf_url}
      %p
        LINK TO GRAPH_PDF
    %a{:href=>@png_url}
      %p
        LINK TO GRAPH_PNG
    %img{:src=>@png_url}





:javascript 
  $(function(){
  $("object").css("color","red");
  $("header").css("color","red");
  });
  
@@ styles
$blue: #3bbfce
$margin: 16px

