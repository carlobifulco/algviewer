require "sinatra"
require 'json'
require "graphviz"
require "hpricot"
require "haml"
require "redis"
require 'digest/md5'
require "sass"
require "rinruby"
require "tempfile"
require "pathname"


# SVG GENERATOR
#-------------
#Restful servis serving from p :8080
#generates graphs stores them temporarly in redis and serves them from there


# needs full path otherwise this crushes
# load "/home/ubuntu/Dropbox/code/pathforms/stock.rb"
# get additional routes
# %w(stock).each {|feature| load "#{feature}.rb"}


#Redis connection
#-----------------

# location of REDIS service. localhost if not test; oterwise redirects to EC2 
if ARGV.length !=0
  $test=true if ARGV[2]=="test"
else
  $test=false
end

puts ARGV[2]
puts $test

#local host if running on ec2; otherwise connect to ec2
$redis=Redis.new(:password=>"redisreallysucks",:thread_safe=>true,:port=>6379) if not $test
$redis=Redis.new(:host => "184.73.233.199", :password=>"redisreallysucks",:thread_safe=>true,:port=>6379) if $test
puts $redis.to_enum


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
    		window.svg_node=e;
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
    
    # one redis per instance
    #local host if running on ec2; otherwise connect to ec2
    @redis=Redis.new(:password=>"redisreallysucks",:thread_safe=>true,:port=>6379) if not $test
    @redis=Redis.new(:host => "184.73.233.199", :password=>"redisreallysucks",:thread_safe=>true,:port=>6379) if $test
    
  end
  
  def add_nodes(nodes,colors=false)
    if not colors
      nodes.each do |node|
         add_node(node)
       end
    else
      nodes_colors=nodes.zip(colors)
      nodes_colors.each do |node_color|
        add_node_color(node_color[0],node_color[1])
        puts "COLORS"
      end
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
  
  def add_node_color(node,color)
    begin
    new_node=@g.add_node(node)
   # text='<<TABLE BORDER="0" CELLBORDER="0" CELLSPACING="0" CELLPADDING="0"><TR><TD FIXEDSIZE="TRUE" WIDTH="300"  ALIGN="CENTER" HEIGHT="60">'+node+'</TD></TR></TABLE>>'
    new_node[:label]=para node
    new_node[:fillcolor]=color
    puts "node added #{node}"
    rescue
   "failed"
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
  
  
  def get_dot 
    dot_doc=@g.output(:dot=>String)
	@dot_md5=Digest::MD5.hexdigest(dot_doc)
	@redis.set @dot_md5, dot_doc
    @redis.expire @dot_md5, 3000
    "#{$HOME}/graph_dot/#{@dot_md5}"
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
    # inserts jscript onclick calls
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

get '/graph_dot/:dot_md5' do
  content_type 'text/x-yaml', :charset => 'utf-8'
  $redis.get params[:dot_md5]
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

#GRaph generation REST
#--------------------

### This takes care of the netsful and ajax requests
### Returns json dictionary
post '/nodes_edges/' do
  colors=false
  graph=Graph.new
  puts params
  nodes=JSON.parse params[:nodes]
  edges=JSON.parse params[:edges]
  colors=JSON.parse params[:colors] if params.has_key?("colors")
  puts " NODES " + nodes.to_s
  puts "EDGES " + edges.to_s
  if colors
    puts "GETTING COLORS #{colors}"
    graph.add_nodes(nodes, colors)
  else
    graph.add_nodes(nodes)
  end
  graph.add_edges(edges)
  @result=graph.get_svg
  @result_pdf=graph.get_pdf
  @result_png=graph.get_png
  @result_dot=graph.get_dot
  {:svg=>@result,:pdf=>@result_pdf,:png=>@result_png,:dot=>@result_dot}.to_json
end



# just to check that the service is alive
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














