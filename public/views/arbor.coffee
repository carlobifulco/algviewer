
$(document).ready =>





# # HELPER FUNCTION
# #----------------
# #  split sentences every 7 words
# def para text
#   a=text.split
#   f=[]
# 
#   a.each do |x|
#       f << x
#       if (f.join(" ").split "\n")[-1].length/7 > 1
#       
#       
#         f<< "\n"
#       elsif x.index "*"
#         f<< "\n"
#       end
#   end
#   f.join " "
# end


  clean=(list)->
    _.reduce(list,(memo,item)->return memo+" "+item).trim()
  window.clean=clean

  para=(text)->
    text_splits=_.select(text.split(" "), (i)->i!="")
    paragraph=[]
    _.each(text_splits,(ts)=>if (paragraph.length%4==0 and paragraph != []) then paragraph.push("\n") else paragraph.push(ts) )
    return clean(paragraph)
  window.para=para


  #Mouse events for arbor
  #-----------------------
      
  class Handler
    
    constructor:(particleSystem)->
      @particleSystem=particleSystem
      @dragged_p=null
    clicked:(e)=>
      console.log("aaaaa")
      pos = $('canvas').offset()
      @mouseP = arbor.Point(e.pageX-pos.left, e.pageY-pos.top)
      @dragged_p = @particleSystem.nearest(@mouseP)
      console.log(@dragged_p)
      if ((@dragged_p and @dragged_p.node) != null) then @dragged_p.node.fixed = true
      $('canvas').bind('mousemove', @dragged)
      $('canvas').bind('mouseup', @dropped)
      return false
    dragged:(e)=>
      console.log("dragged")
      pos = $('canvas').offset()
      s = arbor.Point(e.pageX-pos.left, e.pageY-pos.top)
      if @dragged_p and @dragged_p.node != null
        p = @particleSystem.fromScreen(s)
        @dragged_p.node.p = p
      return false
    dropped:(e)=>
      console.log("dropped")
      if (@dragged_p==null or @dragged_p.node==undefined) then return
      if (@dragged_p.node != null) then @dragged_p.node.fixed = false
      @dragged_p.node.tempMass = 1000
      @dragged_p = null
      $('canvas').unbind('mousemove', @dragged)
      $('window').unbind('mouseup', @dropped)
      @mouseP = null
      return false





  
  #Nodes and Edges 
  #---------------- 
  class Renderer
    init:(sys)=>
      console.log("starting #{sys}")
      @canvas=$("#viewport").get(0)
      @ctx=@canvas.getContext("2d")
      @gfx = arbor.Graphics(@canvas)
      @particleSystem=sys
      @particleSystem.screenSize(@canvas.width, @canvas.height) 
      @initMouseHandling()

    draw_edge:(edge, pt1,pt2)=>
      @ctx.strokeStyle = "rgba(0,0,0, .333)"
      @ctx.lineWidth = 1
      @ctx.beginPath()
      @ctx.moveTo(pt1.x, pt1.y)
      @ctx.lineTo(pt2.x, pt2.y)
      @ctx.stroke()
      #console.log("drawing edge #{edge}")
    draw_node:(node,pt)=>
      w = 150

      
     
      if node['data'] 
        @ctx.fillStyle=node['data']['myColor']
        @gfx.oval(pt.x-w/2, pt.y-w/2, w,w,{fill:node['data']['myColor']})
        #console.log(node['data']['myColor'])
      else
        @ctx.fillRect(pt.x-w/2, pt.y-w/2, w,w)
      @gfx.text(node.name, pt.x, pt.y+7, {color:"black", align:"center", font:"Arial", size:12, width:5})
      #@gfx.text(node.data.text, pt.x, pt.y+7, {color:"black", align:"center", font:"Arial", size:12})
      #console.log(node)
      #console.log("drawing node #{node}")
      
      
    redraw:()=>
      #console.log("redraw")
      #@ctx.fillStyle = "white"
      @gfx.clear()
      @ctx.fillStyle ='white' 
      @ctx.fillRect(0,0, @canvas.width, @canvas.height)
      @particleSystem.eachEdge((edge,pt1, pt2)=>@draw_edge(edge,pt1,pt2))
      @particleSystem.eachNode((node,pt)=>@draw_node(node,pt))
      
    initMouseHandling:()=>
      @dragged=null
      handler=new Handler(@particleSystem)
      $('canvas').mousedown(handler.clicked)
  
  
  #Interface to algviewer
  #-----------------------
  class NodesAndEdges 
    constructor:(graph_name)->
        @user_name=localStorage.user 
        @graph_name=graph_name
        $.when(@colors()).done(()=>@nodes_and_edges())
      
    nodes_and_edges:()=> 
    # get '/nodes_and_edges/:user_name/:graph_name' do
    # content_type :json # form_name=params[:graph_name] #
    #user_name=params[:user_name]
      url="/nodes_and_edges/#{@user_name}/#{@graph_name}" 
      call=$.get(url)
      call.done((e)=>@nodes=e[0]; @edges=e[1];  @add_nodes(@nodes); @add_edges(@edges))
      call.error(()->alert("error"))
      
    colors:()=>
      dfd = $.Deferred()
      @colors_url="/nodes_colors/#{@graph_name}"
      $.get(@colors_url,{"user_name":@user_name, type:"ajax"},(e)=>@color_hash=JSON.parse(e);dfd.resolve())
      return dfd.promise()
      
    add_nodes:(nodes)=>
      #looping around the nodes
      _.each(nodes, (node)=>sys.addNode(node,{myColor:@color_hash[node], text:node, shape:"dot", mass:1}))
      
    add_edges:(edges_list)=>
      #looping around the edges
      _.each(edges_list,(e)=>add_tuples_list(e))
      
  add_tuple=(tuple)->
    sys.addEdge(tuple[0],tuple[1])
  
  add_tuples_list=(tuples_list)->
    _.each(tuples_list,(e)->add_tuple(e))
    
  get_name=()->  
    alg_name=_.last(window.location.pathname.split("/"))
    return alg_name
    
  get_username=()->
    path=window.location.pathname.split("/")
    return path[path.length-2]
    
    
  #fill screen
  $("canvas").attr("height",$(window).height())
  $("canvas").attr("width",$(window).width())
  
  
  sys = arbor.ParticleSystem(1000, 600, 0.5)
  sys.parameters({stiffness:500, repulsion:1000, gravity:false, dt:0.02, friction:0.5})
  sys.screenPadding(100, 100, 100, 100)
  renderer=new Renderer
  sys.renderer = renderer
  # sys.addEdge('a','b')
  # sys.addEdge('a','c')
  # sys.addEdge('a','d')
  # sys.addEdge('a','e')
  # sys.addNode('f', {myColor:"orange", text:"GEKKKI", shape:"dot", mass:1})
  # sys.addNode('w', {myColor:"pink",text:"HELLO", mass:1})
  # sys.addEdge('a','w')
  # sys.addEdge('w','d')
  # sys.addNode("a",{myColor:"blue"})
  # sys.addEdge("f","w")
  alg_name=get_name()
  ne= new NodesAndEdges(alg_name)
 
  
  window.renderer=renderer
  window.NodesAndEdges=NodesAndEdges
  window.ne=ne
  window.add_tuple=add_tuple
  window.add_tuples_list=add_tuples_list
  window.get_name=get_name
  window.get_username=get_username
 
  #%canvas#viewport{:width =>'800', :height =>'600'}
