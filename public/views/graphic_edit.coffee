# utility for visualization of objects
`function concat_object(obj) {
  str='';
  for(prop in obj)
  {
    str+=prop + " value :"+ obj[prop]+"\n";
  }
  return(str);
}`



window.concat_object=concat_object

#global for dragging
window.pos={}
#global for layout of yaml
window.counter=0
#global for image resizing
window.image_is_large=false

#on load jquery
$(document).ready =>


#UTILITY FUNCTIONS
#-----------------
  get_alg_name=()->
    alg_name=_.last(window.location.pathname.split("/"))  
  window.get_alg_name=get_alg_name
  
  alg_text_edit=()->  
    window.location.href="/edit_text/#{get_alg_name()}"

  alg_view=()->
    window.location.href="/view/#{get_alg_name()}"

#GLOBALS
#-------
  
  # grid size GLOBALS
  grid=48
  x_start=grid*2
  y_start=(grid*4)+$(".new_box").position().top
  
  #block caching
  $.ajaxSetup({cache: false})
  
  
#RGB -> HEX
#------------

  # argument in "rgb(0, 70, 255)" format
  rgb2hex= (rgb)->
    rgb = rgb.match(/^rgb\((\d+),\s*(\d+),\s*(\d+)\)$/);
    return "#" +
    ("0" + parseInt(rgb[1],10).toString(16)).slice(-2) +
    ("0" + parseInt(rgb[2],10).toString(16)).slice(-2) +
    ("0" + parseInt(rgb[3],10).toString(16)).slice(-2)
  window.rgb2hex=rgb2hex



#New text boxes
#--------------

  # a new box
  new_box=(x,y,text,counter_id,add_class="")->
    #alert add_class if add_class
    text_box=$("<div id='#{hex_md5(text.trim())}' class='ui-widget-content ui-corner text_box #{add_class}' style='position: absolute; left: #{x}px; top: #{y}px'>#{text}</div>")
    text_box.draggable({"grid":[grid,grid],"opacity":0.35,"refreshPositions":"true","scroll":true}).appendTo(".new_box")
    text_box.draggable("stop":offset)
    # in pic_drop
    return text_box

  # makes boxes out of list of tuples 0=text,1=indent   
  make_layout=(i)->
    text=i[0]
    x=x_start+(i[1]*grid)
    y=y_start+(window.counter*grid)
    new_box(x,y,text, window.counter)
    #this takes care of the vertical order
    window.counter+=1
  window.make_layout=make_layout
  
  #initial box do be added in middle of screen
  initial_box=(evt)->
    evt.stopPropagation()
    evt.preventDefault()
    text=String(document.text_form.text_content.value)
    document.text_form.text_content.value=""
    text="New box; enter new text in the entry form, select me and press Edit Box to change me" unless text
    #position is calculated based on the colorpicker absolute entry and then mapped to the grid
    # makes integers
    x=(($(window).width()/2)/grid).toFixed()*grid
    console.log x
    pos=$("#colorpicker").offset()
    y=(y_start+((pos.top+150)/grid).toFixed()*grid)
    # sass initial_box
    new_box(x,y,text,window.counter,"initial_box")
    new_text=document.text_form.text_content.value
    $("#text_entry").focus()
    $('.initial_box').effect('highlight', {}, 5000)
    #back to orange; also unbind
    $(".initial_box").bind( "dragstart",(e,ui) ->console.log(e); $(e.currentTarget).removeClass("initial_box").unbind("dragstart"))
    
    
  copy_boxes=()->
  #xxx
    pos=$("#colorpicker").offset()
    x=(($(window).width()/2)/grid).toFixed()*grid
    z=(i.innerText for i in $(".ui-selected"))
    console.log z
    a=0
    for i in z
      do (i)=>
        console.log i
        y=(y_start+((pos.top+150+a)/grid).toFixed()*grid)
        new_box(x,y,i,window.counter,"initial_box")
        a+=grid
        console.log a
    #blinking
    $('.initial_box').effect('highlight', {}, 5000)
    #back to orange; also unbind
    $(".initial_box").bind( "dragstart",(e,ui) ->console.log(e); $(e.currentTarget).removeClass("initial_box").unbind("dragstart"))
    
        
  window.copy_boxes=copy_boxes
 
  
  #enters a new box on manual text entry
  make_rect=(evt)->
    evt.stopPropagation()
    evt.preventDefault() 
    b=$("#containment-wrapper")
    text=String(document.text_form.text_content.value)
    document.text_form.text_content.value=""
    text="New box; enter new text in the entry form, select me and press Edit Box to change me" unless text
    new_box(x_start,(y_start-grid*2),text,window.counter)
    new_text=document.text_form.text_content.value 
    #alert(new_text)
    #$(".selectable").selectable({stop:get_selected, unselected:()->alert("sdsdsd")}) 
    $("#text_entry").focus()
    window.counter+=1
  
  #updates the text of a box
  edit_text=()->
    b=get_selected()
    if b.length==1  
      $(b[0]).text($("#text_entry").val())
      $("#text_entry").val("")
    else
      $("#text_entry").val("")
    $("#text_entry").focus()
    


#From boxes to yaml
#-----------------

  #renders yaml alg structure 
  alg_text=(text_positions)->  
    text="\n"
    # presumes the first box is the leftest. better would be the most left handed
    baseline=text_positions[0][1]
    for text_position in text_positions
      #[0] contains the actual text 
      # screening for possible complications
      # indent level needs to be rounded 
      indent_level=Math.round((text_position[1]-baseline)/grid)
      offset=text_multiply("  ",indent_level)
      #console.log(indent_level)
      if offset>old_offset
        text+=old_offset+"-"+"\n"
      if text_position[1]==baseline
        text+="\n"
      #if (text_position[0].search(":")!=-1)
      # alert("Error, please do not use : or ' or \"; they all need to be escaped (i.e. preceeded by \\)")
      text_to_be_added=text_position[0].trim()
      text+= offset+"- "+ text_to_be_added + "\n"
      old_offset=offset
    text
  
  #utility for yalm alg structure
  text_multiply=(text,n)->
    a=[]
    for i in [0...n] 
      a.push(text)
    a.join("")
  window.text_multiply=text_multiply
  
  #sorts the boxes so that they can get rendered in text in order
  sort_rect=()->
    text_boxes= $(".text_box")
    sorted_boxes=_.sortBy(text_boxes, get_pos) 
    window.sorted_boxes=sorted_boxes
    text_positions=(make_text_position(sorted_box) for sorted_box in sorted_boxes)
    window.text_positions=text_positions
    text_positions

  
  # get postions from a box
  make_text_position=(text_box)->
    text=$(text_box).text()
    pos_left=$(text_box).position().left
    [text,pos_left]
    
  # transform the boxes in a yaml alg
  boxes_to_yaml=()->
    if sort_rect!=[]
      result=alg_text(sort_rect()) 
    # for debugging
      window.yaml=result
      return result
  window.boxes_to_yaml=boxes_to_yaml


# Selected box
#-------------
  # css for when selected
  chosen=()->
    #$(".text_box").css("color","black")
    #$(".ui-selected").css("color","red")
    #$(".ancor").css("color","black")
  
  
# Kill Box
#---------- 
  #kills a box
  del_entry=()->
    $(".ui-selected").remove()
    yaml_structure=boxes_to_yaml()
    render_alg()
    $("#text_entry").focus()



#Multiple dragging business  
#--------------------------
  
  # u is the dragged item; u.position.left and top is where it got dragged
  # gets always called one done with dragging
  offset=(e,u)->
    # just one gets dragged, the other folllow
    dragged=$(u.helper[0])[0]
    new_data=get_draggable_data(dragged)
    x=new_data.x
    y=new_data.y
    id=new_data.id
    #alert([id,new_data.text])
    #stores pos
    window.pos[_.size(window.pos)]=new_data
    #gets to the previous pos
    old_data=window.pos[_.size(window.pos)-2]
    if old_data
      old_data=_.detect(old_data,(i)->return i.id==id)
      if old_data
        x_delta=new_data.x-old_data.x
        y_delta=new_data.y-old_data.y
        move(id,x_delta,y_delta)
    # remove item from selection
    $(dragged).removeClass("ui-selected")
    render_alg()
    window.u=dragged

  # returns all selected items and attaches an id,text,x,y dict to window.pos
  # also enters selected text in text entry of only one box is selected
  get_selected=()->
    s=_.sortBy($(".ui-selected"), get_pos) 
    data=(get_draggable_data(i) for i in s)
    
    window.pos[_.size(window.pos)]=data 
    if s.length==1 
      if $("#text_entry").val()==""
        $("#text_entry").val($.trim($(s).text()))
        $("#text_entry").focus()
      else
        $("#text_entry").focus()
        
      #$(s[0]).selectable("unseleted":()->$("#text_entry").v)
    return s
    #alert(s)
  window.get_selected=get_selected
  
  #returns id, text, x, y of a draggable
  get_draggable_data=(d)->
    r={}
    p=$(d).position()
    if p
      r["x"]=p.left
      r["y"]=p.top
      r["text"]=$(d).text()
      r["id"]=$(d).attr("id")
      window.r=r
      return r
      
  window.get_draggable_data=get_draggable_data
  
  # makes a draggable in absolute position; does not keep it selected so that process is reseted
  make_draggable=(id,text,x,y)->
    text_box=$("<div id='#{id}' class='ui-widget-content selectable text_box' style='position: absolute; left: #{x}px; top: #{y}px'>#{text}</div>")
    text_box.draggable({"grid":[grid,grid],"opacity":0.35,"refreshPositions":"true","scroll":true}).appendTo(".new_box")
    text_box.draggable("stop":offset)
    return text_box
  window.make_draggable=make_draggable
  
  #cut all selected except for the dragged element and enter their data (text,x,y) in array 
  cut=(id)->
    #all elements in order
    s=get_selected()
    #remove the id
    s=_.reject(s,(i)->return i.id==id)
    data=(get_draggable_data(i) for i in s)
    ($(i).remove() for i in s)    
    #window.cut=data
    return data
  window.cut=cut
  
  # moves all the objects, except the dragged one, which is provided in the id
  move=(id, x_delta,y_delta)->
    all=cut(id)
    (make_draggable(i.id,i.text,i.x+x_delta,i.y+y_delta) for i in all)
    set_boxes_colors()
    window.add_drop()
  window.move=move

  unselected=()->
    chosen()
    
  get_pos=(text_box)->
    $(text_box).position().top
  window.get_pos=get_pos
  
  #Graph resizing and dysplay
  #--------------------------
  
  #finds largest parameter of the graph; then sets that parameter to max based on space available in right corner nd the other to nil
  #for dysplay of the graph in the R half of window
  resize_graph=()->
    image=$('#graph_preview')
    window.image=image
    w_height=$(window).height()
    w_width=$(window).width()
    # image_height=w_height-100
    w=image.width()
    h=image.height()
    if w>h
      # document half
      image.width(350)
      image.height("")
    else
      #using window height; document set to large number
      image.height(350)
      image.width("")
    # set global standardt for resizing
    window.image_h=image.height()
    window.image_w=image.width()
    window.image_top=image.css("top")
  
  window.resize_graph=resize_graph
    
    
  
  # inline rendering
  # of graph
  render_inline=(data)->
    console.log(data.png)
    anchor=$("#inline_graph")
    window.z=data
    anchor.html("<img class=inline_graph id=graph_preview src='#{data.png}'></img>")
    image=$("#graph_preview")
    image.hide()
    image.click(()->expand_graph())
    # resize picture and show once ready
    image.load(()->resize_graph();image.show())

    # on old for now
    
  
  # to be activated on click on graph
  expand_graph=()->
    im= $('#graph_preview')
    if not window.image_is_large
      
      im.addClass("image_full")
      im.css("opacity","1")
      h=($(window).height()-100)
      w=($(window).width()-50)
      if window.image_h>window.image_w
        im.height(h)
        im.width("")
        im.css("top",5)
      if window.image_w>=window.image_h
        im.width(w)
        im.height("")
        im.css("top",5)
      window.image_is_large=true
      im.effect("slide",()->im.show())
    else
      im.removeClass("image_full")
      im.css("height",window.image_h)
      im.css("width",window.image_w)
      im.css("top",window.image_top)
      window.image_is_large=false
      $("#text_entry").focus()
        

  #Color wheeel 
  #------------
  #applies color to selectio and stores values in local storage upon each change.
  #these are the reimplemented on each reload of the alg
  #the use of local storage makes this for now local browser specific 
  colorme=(color)->
    console.log(color.color.valueElement.value)
  window.colorme=colorme
  
  
  
  # Apply color to all boxes
  # gets colors from redis
  set_boxes_colors=()->
    #request colors from redis
    graph_name=get_alg_name()
    #paint_boxes callback does the job of painting
    # post '/get_graph_colors' do
    #   graph_name=params[:graph_name]
    #   user_name=params[:user_name]
    $.post("/get_graph_colors",{"graph_name":alg_name,"user_name":localStorage.user,"type":"ajax"}).done((colors)->paint_boxes(JSON.parse(colors)))
    return ""
  window.set_boxes_colors=set_boxes_colors
  
  
  #callback for AJAX redis colors
  paint_boxes=(colors_list)->
    #alert(colors_list)
    boxes=get_boxes()
    #zip index and col and then apply them to each box    
    position_colors=_.zip([0...colors_list.length],colors_list)
    window.position_colors=position_colors
    ($(boxes[pos_col[0]]).css("background-color",pos_col[1]) for pos_col in position_colors)
    # this needs to be called AFTER the colors are painted otherwise fires to early before rendering
    #$.farbtastic("#colorpicker").setColor("#f896c2")
    render_alg()

  # Get colors from boxes
  # loops over all boxes and gets their color
  # stores theyr value in redis via ajax to store_graph_colors
  store_boxes_colors=()->
    bc={}
    #boxes in vertical order
    sorted_boxes=get_boxes()
    if sorted_boxes
      colors=($(i).css("background-color") for i in sorted_boxes)
      # store colors on redis
      alg_name=get_alg_name()
      colors=JSON.stringify(colors)
      # colors are stored in redis 
      # post '/store_graph_colors' do
      #       colors=JSON.parse(params[:colors])
      #       graph_name=params[:graph_name]
      #       user_name=params[:user_name]
      $.post("/store_graph_colors",{"colors":colors,"graph_name":alg_name,"user_name":localStorage.user}).done(console.log("colors stored"))
    return ""
  window.store_boxes_colors=store_boxes_colors
    
  
  
  #get boxes in vertical order
  get_boxes=()->
    text_boxes= $(".text_box")
    sorted_boxes=_.sortBy(text_boxes, get_pos)
  window.get_boxes=get_boxes
  
  
  #boxes_text
  boxes_text=()->
    ( $(i).text().trim() for i in get_boxes())
  window.boxes_text=boxes_text
  
  #returns zipped pairs of nodes and colors
  get_nodes_colors=()->
    selected=[]
    nodes_colors=_.zip(boxes_text(),sorted_colors())
  window.get_nodes_colors=get_nodes_colors
  

  
  #get colors in sorted order
  sorted_colors=()->
    sorted_boxes=get_boxes()
    colors=($(i).css("background-color") for i in get_boxes())
  window.sorted_colors=sorted_colors
  


  
  #Color wheel called function
  #Applies color to all selected items
  # stores the situation so that it can be reapplied
  choose_color=(color)->
    #alert(color)
    $(get_selected()).css("background",color)
    store_boxes_colors()
  window.choose_color=choose_color

  
  #Rendering of colored graphs
  #---------------------------
  
  # returns hash {text:hex_of_color}
  unique_colors=()->
    counter=0
    all_colors=sorted_colors()
    all_boxes=boxes_text()
    # make pairs with (pos,box_text)
    positions_boxes_pairs=_.zip([1..all_boxes.length],all_boxes)
    #more pairing, now (col,(pos,text))
    boxes_colors_pairs=_.zip(all_colors,positions_boxes_pairs)
    window.boxes_colors_pairs=boxes_colors_pairs
    box_color_hash={}
    # make {} -> {text:col}
    (hash_maker(box_color_hash,i) for i in boxes_colors_pairs)
    #storing boxes colors in redis
    alg_name=get_alg_name()
    #post '/nodes_colors/:graph_name' do graph_name=params[:graph_name] colors=params[:colors] user_name=params[:user_name]
    $.post("/nodes_colors/#{alg_name}",{"colors":JSON.stringify(box_color_hash), "user_name":localStorage.user, type:"ajax"})
    # returning boxes colors
    box_color_hash
    
  window.unique_colors=unique_colors
  
  #utility for possible colored graphs; returns JSON
  # Usage: update of the graph calls colors_to_hex(unique_colors())
  # useless in the current implementation
  colors_to_hex=(colors_array)->
    JSON.stringify((rgb2hex(i) for i in colors_array))
  window.colors_to_hex=colors_to_hex
  
  #hash {text:matching_color}
  hash_maker=(hash,value_pair)->
    #(col,(pos,text))
    text=value_pair[1][1]
    pos=value_pair[1][0]
    color=value_pair[0]
    if not hash[text]
      hash[text]=rgb2hex(color)


  #Rendering and Saving
  #--------------------


  # ajax call to /view_text 
  # and when results come back calls rendering_ok for showing the 
  # results
  render_alg=()->
    $("#progressbar" ).progressbar("value":25)
    yaml_structure=boxes_to_yaml()
    colors=unique_colors()
    #show on tab inline rendering
    #z=$.post("/graphic_edit_view",{"text":yaml_structure,"hex":colors, "dataType":"json"},(data)->render_inline(JSON.parse(data)))
    # and save
    save(yaml_structure)
    $("#text_entry").focus()
    #in pic_drop coffee file
    # add drop capability anytime there is a change in the graph
    add_drop()

  save=(yaml_structure)->
    # post '/text/:form_name' do
    #   form_name=params[:form_name]
    #   user_name=params[:user_name]
    #   content=params[:content]
    # get algname
    alg_name=_.last(window.location.pathname.split("/"))
    url="/text/#{alg_name}"
    user=localStorage.user
    # actual save
    $.post(url,{"content":yaml_structure,"form_name":alg_name, "user_name":user, "type":"ajax"}).done(success)

  success=(r)->
    $("#progressbar" ).progressbar("value":100)
    console.log(r)
    render_inline(r)

  #saving
  save_alg=()->
    yaml=boxes_to_yaml()
    alg_name=_.last(window.location.pathname.split("/"))
    window.alg_name=alg_name
    window.yaml=yaml
    #$.post("/upload_text",{"form_content":yaml,"form_name":alg_name,"type":"ajax"},(data)->success())
  window.save_alg=save_alg


  #debug
  window.alg_text=alg_text
  window.sort_rect=sort_rect




  # $(document).bind('keydown', 'Return', (evt)->make_rect(evt))
  # $(document).bind('keydown', 'Ctrl+e', enter_text)
  # $(document).bind('keydown', 'Ctrl+a', alert)

  # bar and tabs
  $("#progressbar").progressbar("value":0)
  $("#tabs").tabs()




  
  #Initial Rendering on load of the graph
  #--------------------------------------

  # gets boxes struct from ajax call and then lays them out
  initial_layout=(text_indent)->
    # parsing the JSON data
    boxes_struct=JSON.parse(text_indent)
    if boxes_struct
      _.each(boxes_struct, (i)->make_layout(i))
      # color boxes
      set_boxes_colors()
      #render alg
      render_alg()
      #add Drop; this function is in pic_drop.coffee
      add_drop()


    # zero counter for next run
    window.counter=0
    
  # hides a copy of the alg structure
  $(".hide").hide()
  
  # actually get the struc and renders it
  alg_name=_.last(window.location.pathname.split("/"))  
  # get '/ajax_text_indent/:form_name' do
  #   form_name=params[:form_name]
  #   user_name=params[:user_name]
  user_name=localStorage.user
  z=$.get("/ajax_text_indent/#{alg_name}",{"user_name":user_name}).done((text_indent)->initial_layout(text_indent))
  #$('#colorpicker').colorPicker({click:(color)->alert color})
  #Activate selector  
  #$.farbtastic("#colorpicker").setColor("#f896c2")
  #$("#colorpicker").farbtastic(choose_color)
  #$("#colorpicker").selectable()
  

    
  
  
  
  #  Bindings
  #--------
  
  # funtions for key bindings



  

  
  
  # Buttons
  $("#home").bind 'click', ()->window.location.pathname="/"
  $("#new_entry").bind 'click', initial_box
  $("#del_entry").bind 'click', del_entry
  $("#text_edit").bind 'click', alg_text_edit
  $("#edit_entry").bind 'click', edit_text 
  $("#view").bind 'click', alg_view 
  $("button").button()
  
  #draggables selectables
  $(".selectable").selectable({"selected":chosen})
  $(".draggable").draggable()
  
  #all selectable stop linked to function
  $(".selectable").selectable({stop:get_selected})  
  
  #error log
  $(document).ajaxError(()=>alert("There is an error in your graph structure. Please fix your boxes position."))  

  
  #KEYS bindings
  #--------------
  
  # text entry focus
  $("#text_entry").focus()
  $("#text_entry").bind('keydown', 'ctrl+c', copy_boxes)
  #Return
  $("#text_entry").bind('keydown', 'return', initial_box)
  $("#text_entry").bind('keydown', 'ctrl+x', del_entry)
  
  #.keydown((e)->initial_box(e) if e.keyCode==13 )
  
  

  enter=(e)->
    e.stopPropagation()
    selected=$(".ui-selected")[0] 
    if e.keyCode==13 
      alert e.keyCode
      if not selected
        make_rect(e)
      else
        e.preventDefault() 
        selected.innerText=document.text_form.text_content.value
        document.text_form.text_content.value=""
        render_alg()
  

 
  
  


  
  
  





  

  


  





