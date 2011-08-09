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




#REDIS GRAPH REPO
#-----------------------
#local host if running solo; otherwise connect to ec2
if $0 == __FILE__
  $redis_svg=Redis.new(:password=>"redisreallysucks",:thread_safe=>true,:port=>6379) 
  #HAML if running solo
  set :haml, {:format => :html5 }
else
  $redis_svg=Redis.new(:host =>$HOST, :password=>"redisreallysucks",:thread_safe=>true,:port=>6379) 
end





# HELPER FUNCTION
#----------------
#  split sentences every 7 words
def para text
  text.strip!
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


# Manipulation of SVG output
#---------------------------
#now able to properly manipulate SVG dom from chrome


module JavaScript
  # this is bound to node.set_attribute "onclick", "test(this)" in the svg generation
  #is attached at the bottom of the SVG file
  def get_javascript
    #loads jquery and svg_graph.js
    #SVG graph is where the logic for the SVG visualization relies
    return '
    <script src="/jquery_min_1.5.js" type="application/x-javascript"></script>
    <script src="/underscore-min.js" type="application/x-javascript"></script>
    <script src="/mustache.js" type="application/x-javascript"></script>
    <link href="/facebox.css" media="screen" rel="stylesheet" type="text/css"/>
    <script src="/facebox.js" type="text/javascript"></script>
    <link  href="/sass"  rel="stylesheet" type="text/css" media="screen"/>
    <script type="text/javascript" charset="utf-8">
    url="/views/pic_drop.js";
    $.getScript(url, function () {console.log("pic_drop loaded")});
    url="/views/svg_graph.js";
    $.getScript(url, function () {console.log("svg_graph loaded")});

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


# dot Rendering of YAML structures
#---------------------------------

class Graph
  
  include JavaScript
  def initialize(algname=false,username=false)
    puts "I am getting #{username}" if username
    @algname=algname if algname
    @username=username if username
    @g=GraphViz.new(:G,:type=>:digraph,:rankdir=>"TB",:center=>"true")
    @g.node[:fontsize] = "14"
    @g.node[:shape]    = "box"
    #@g.node[:color]    = "#ddaa66"
    @g.node[:style]    = "filled, rounded"
    @g.node[:shape]    = "box"
    @g.node[:penwidth] = "1"
    @g.node[:fillcolor]= "#ffeecc"
    @g.node[:fontcolor]= "#775500"
    @g.node[:margin]   = "0.15"
    
    # @g.edge[:color]    = "#999999"
    # @g.edge[:weight]   = "1"
    # @g.edge[:fontsize] = "6"
    # @g.edge[:fontcolor]= "#444444"
    # @g.edge[:fontname] = "Verdana"
    # @g.edge[:dir]      = "forward"
    # @g.edge[:arrowsize]= "0.5"
    
    # one redis per instance
    #local host if running on ec2; otherwise connect to ec2
    if $0 == __FILE__
      @redis=Redis.new(:password=>"redisreallysucks",:thread_safe=>true,:port=>6379) 
    else
      @redis=Redis.new(:host =>$HOST, :password=>"redisreallysucks",:thread_safe=>true,:port=>6379) 
    end
  end

  # options setting; called below by add_nodes
  # replaces the default settings
  def circle
    @g.node[:shape]="circle"
    @g.node[:style]= "filled, rounded"
    @g.node[:margin]   = "0"
  end
  
  def ellipse
    @g.node[:shape]="ellipse"
    @g.node[:style]= "filled, rounded"
    @g.node[:margin]   = "0"
  end

  # add node an if also provided with a color hash sets color[node]  
  def add_nodes(nodes,colors=false,options=false)
    if 
      # options take care of here
      options and options.has_key? "circle" and options["circle"] then circle()
    elsif
      options and options.has_key? "ellipse" and options["ellipse"] then ellipse()
    end
    colors=JSON.parse(colors) if colors.class==String
    puts "these are the colors I got: #{colors} #{colors.class}"
    nodes.each do |node|
      if colors
        add_node_color(node,colors[node])
        puts "THIS IS WHAT I ADDED #{node}, #{colors[node]}"
      else
        add_node node
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
    new_node[:color]    = color
    puts "colored node added #{node} #{color}"
    rescue
   "failed"
    end
  end
  
  def add_node(node)
    begin
    new_node=@g.add_node(node)
   # text='<<TABLE BORDER="0" CELLBORDER="0" CELLSPACING="0" CELLPADDING="0"><TR><TD FIXEDSIZE="TRUE" WIDTH="300"  ALIGN="CENTER" HEIGHT="60">'+node+'</TD></TR></TABLE>>'
    new_node[:label]=para node
    new_node[:color]    = "#ddaa66"
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
    "/graph_dot/#{@dot_md5}"
  end
  
  def get_pdf 
    pdf_doc=@g.output(:pdf=>String)
	  @pdf_md5=Digest::MD5.hexdigest(pdf_doc)
	  @redis.set @pdf_md5, pdf_doc
    @redis.expire @pdf_md5, 3000
    "/graph_pdf/#{@pdf_md5}"
  end
  
  def get_png 
    doc=@g.output(:png=>String)
	  @png_md5=Digest::MD5.hexdigest(doc)
	  @redis.set @png_md5, doc
    @redis.expire @png_md5, 3000
    "/graph_png/#{@png_md5}"
  end
  
  def get_svg
    svg_doc=@g.output(:svg=>String)
    # inserts jscript onclick calls
    d=clean_svg(Hpricot.parse(svg_doc))
    # if algname doublecklick links to images
    if @algname
      d.search("g[@class=node]").each do |node|
        text=(node.search "title")[0].innerHTML
        text.gsub! "\n", ""
        #set i to md5
        m5=Digest::MD5.hexdigest(text)
        puts "text=#{text}; md5=#{m5}"
        node.set_attribute "id",m5
        node.set_attribute "algname",@algname
        #add binding for on click
        #node.set_attribute "onclick", "show_thumbs(this)"
      end
    end
    @result="<!DOCTYPE html>
    <html>
      <body>"
    @result=d.to_s
    @result+=get_javascript
    @result+=" <algname id=#{@algname}></algname> <div id=thumbs> </div> </body>
    </html>"
    @svg_md5=Digest::MD5.hexdigest(@result)
    @redis.set @svg_md5, @result
    #svg is stored in memory for rendering
    #@redis.expire @svg_md5, 3000
    return "/graph/#{@svg_md5}" unless @username
    "/graph/#{@username}/#{@svg_md5}"
  end
end

#SERVING OF Graphs Stored in REDIS
#---------------------------------

get '/graph_pdf/:pdf_md5' do
  content_type "application/pdf"
  $redis_svg.get params[:pdf_md5]
end

get '/graph/:svg_md5' do

  #content_type "image/svg+xml"
  $redis_svg.get params[:svg_md5]
end

get '/graph_png/:png_md5' do
  content_type "image/png"
  $redis_svg.get params[:png_md5]
end

get '/plot_pdf/:pdf_md5' do
  content_type "image/png"
  $redis_svg.get params[:pdf_md5]
end

get '/graph_dot/:dot_md5' do
  content_type 'text/x-yaml', :charset => 'utf-8'
  $redis_svg.get params[:dot_md5]
end

get '/graph/*/:svg_md5' do
  username=params["splat"][0]
  $redis_svg.get params[:svg_md5]
end






