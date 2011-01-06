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

#GLOBALS
#-------
	
	# grid size GLOBALS
	grid=48
	x_start=grid*2
	y_start=(grid*4)+$(".new_box").position().top
	
	#block caching
	$.ajaxSetup({cache: false})


#New text boxes
#--------------

	# a new box
	new_box=(x,y,text,counter_id)->
		text_box=$("<div id='#{counter_id}' class='ui-widget-content ui-corner selectable text_box' style='position: absolute; left: #{x}px; top: #{y}px'>#{text}</div>")
		text_box.draggable({"grid":[grid,grid],"opacity":0.35,"refreshPositions":"true","scroll":true}).appendTo(".new_box")
		text_box.draggable("stop":offset)
		#text_box.draggable({stop:"render_alg"})
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
	
	
	#enters a new box on manual text entry
	make_rect=(evt)->
		evt.stopPropagation()
		evt.preventDefault() 
		b=$("#containment-wrapper")
		text=String(document.text_form.text_content.value)
		document.text_form.text_content.value=""
		text="new box; select me, enter the text in the empty box and press control-e to change me" unless text
		new_box(x_start,(y_start-grid*2),text,window.counter)
		new_text=document.text_form.text_content.value 
		#alert(new_text)
		$(".selectable").selectable({stop:()->get_selected()})	
		$("#text_entry").focus()
		window.counter+=1
	
	#updates the text of a box
	edit_text=()->
		b=$(".ui-selected")[0]
		if b !=""
			b.innerText=document.text_form.text_content.value
			document.text_form.text_content.value=""


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
			#	alert("Error, please do not use : or ' or \"; they all need to be escaped (i.e. preceeded by \\)")
			text+=(offset+"- "+ text_position[0].trim() +"\n")
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
		result=alg_text(sort_rect())
		# for debugging
		window.yaml=result
		return result
	window.boxes_to_yaml=boxes_to_yaml


# Selected box
#-------------
	# css for when selected
	chosen=()->
		$(".text_box").css("color","black")
		$(".ui-selected").css("color","red")
		$(".ancor").css("color","black")
	
	
# Kill Box
#----------	
	#kills a box
	del_entry=()->
		$(".ui-selected").remove()
		yaml_structure=boxes_to_yaml()
		render_alg()



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
		$(dragged).removeClass("ui-selected").css("color","black")
		render_alg()
		window.u=dragged

	# returns all selected items and attaches an id,text,x,y dict to window.pos
	get_selected=()->
		s=_.sortBy($(".ui-selected"), get_pos) 
		data=(get_draggable_data(i) for i in s)
		
		window.pos[_.size(window.pos)]=data 
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
	window.move=move

	unselected=()->
		chosen()
		
	get_pos=(text_box)->
		$(text_box).position().top
	window.get_pos=get_pos
	
	#Graph resizing and dysplay
	#--------------------------
	
	#finds largest parameter of the graph; then sets that parameter to max based on window size and the other to nil
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
			image.width((w_width/2)-50)
			image.height("")
		else
			#using window height; document set to large number
			image.height((w_height-150))
			image.width("")
		# set global standardt for resizing
		window.image_h=image.height()
		window.image_w=image.width()
		window.image_top=image.css("top")
	
	window.resize_graph=resize_graph
		
		
	
	# inline rendering
	# of graph
	render_inline=(data)->
		anchor=$("#inline_graph")
		window.z=data
		anchor.html("<img class=inline_graph id=graph_preview src=#{data.png}></img>")
		image=$("#graph_preview")
		image.hide()
		image.click(()->expand_graph())
		# resize picture and show once ready
		image.load(()->resize_graph();image.show())

		# on old for now
		
	
	# to be activated on click on graph
	expand_graph=()->
		im=	$('#graph_preview')
		if not window.image_is_large
			
			im.addClass("image_full")
			h=($(window).height()-100)
			w=($(window).width()-50)
			if window.image_h>window.image_w
				im.height(h)
				im.width("")
				im.css("top",5)
			if window.image_w>=window.image_h
				im.width(w)
				im.height("")
				im.css("top",100)
			window.image_is_large=true
			im.effect("bounce",()->im.show())
		else
			im.removeClass("image_full")
			im.css("height",window.image_h)
			im.css("width",window.image_w)
			im.css("top",window.image_top)
			window.image_is_large=false
			$("#text_entry").focus()
			
	


	#Rendering and Saving
	#--------------------

		
	# ajax call to /view_text 
	# and when results come back calls rendering_ok for showing the 
	# results
	render_alg=()->
		$("#progressbar" ).progressbar("value":25)
		yaml_structure=boxes_to_yaml()
		#show on tab inline rendering
		z=$.post("/graphic_edit_view",{"text":yaml_structure,"dataType":"json"},(data)->render_inline(JSON.parse(data)))
		# and save
		save(yaml_structure)
		$("#text_entry").focus()
		
	save=(yaml_structure)->
		# get algname
		alg_name=_.last(window.location.pathname.split("/"))
		# acutal save
		$.post("/upload_text",{"form_content":yaml_structure,"form_name":alg_name,"type":"ajax"},(data)->success())

	success=()->
		$("#progressbar" ).progressbar("value":100)

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
	
	
	get_alg_name=()->
		alg_name=_.last(window.location.pathname.split("/"))	
	
	alg_text_edit=()->	
		window.location.href="/edit_text/#{get_alg_name()}"
	
	alg_view=()->
		window.location.href="/view/#{get_alg_name()}"
	
		

	#Bindings
	#--------
	
	#####keys bindings
	
	#enter text or edit box
	enter=(e)->
		e.stopPropagation()
		selected=$(".ui-selected")[0] 
		if e.keyCode==13 
			if not selected
				make_rect(e)
			else
				e.preventDefault() 
				selected.innerText=document.text_form.text_content.value
				document.text_form.text_content.value=""
				render_alg()
	
	#Ctrl			
	$(document).keyup((e)-> window.is_ctrl=false if e.keyCode==17)
	#Return
	$("#text_entry").keydown((e)->enter(e))
	
	
	
	# Buttons
	$("#home").bind 'click', ()->window.location.pathname="/"
	$("#new_entry").bind 'click', make_rect
	$("#del_entry").bind 'click', del_entry
	$("#text_edit").bind 'click', alg_text_edit
	$("#edit_entry").bind 'click', edit_text 
	$("#view").bind 'click', alg_view 
	$("button").button()
	
	#draggables selectables
	$(".selectable").selectable({"selected":chosen, "unselected":unselected})
	$(".draggable").draggable()
	
	#all selectable stop linked to function
	$(".selectable").selectable({stop:()->get_selected()})	
	
	#error log
	$('#error_log').ajaxError(()=>alert("ERROR IN YOUR GRAPH STRUCTURE. PLEASE FIX YOUR BOXES POSITION!!!"))
	
	
	

	#Color wheeel 
	#------------
	#applies color to selectio ans tores values in local storage upon each change.
	#thes are the reimplemented on each reload of the alg
	#the use of local storage makes this for now local browser specific 
	
	#get boxes in vertical order
	get_boxes=()->
		text_boxes= $(".text_box")
		sorted_boxes=_.sortBy(text_boxes, get_pos)
	
	#Color wheel called function
	#Applies color to all selected items
	choose_color=(color)->
		$(get_selected()).css("background",color)
		store_boxes_colors()
		
		
	#Activate selector	
	$("#colorpicker").farbtastic(choose_color)
	
	
	# Get colors from boxes
	# loops over all boxes and gets their color
	# stores theyr value in localStorage 
	store_boxes_colors=()->
		bc={}
		#boxes is verical order
		sorted_boxes=get_boxes()
		colors=($(i).css("background-color") for i in sorted_boxes)
		#store this in localStorage variable composed of alg name and _colors
		color_key="#{get_alg_name()}_colors"
		localStorage.setItem(color_key,JSON.stringify(colors))
		
	window.store_boxes_colors=store_boxes_colors
	
	# Apply color to box
	set_boxes_colors=()->
		color_key="#{get_alg_name()}_colors"
		colors_list=JSON.parse(localStorage.getItem(color_key))
		boxes=get_boxes()
		#zip index and col and then apply them to each box
		position_colors=_.zip([0...colors_list.length],colors_list)
		window.position_colors=position_colors
		($(boxes[pos_col[0]]).css("background-color",pos_col[1]) for pos_col in position_colors)
	window.set_boxes_colors=set_boxes_colors
	
		
	
	
	#Initial Rendering on load of the graph
	#--------------------------------------

	# gets boxes struct from ajax call and then lays them out
	initial_layout=(text_indent)->
		# not sure while I need ot parse this twice
		boxes_struct=JSON.parse(JSON.parse(text_indent))
		window.boxes_struct=boxes_struct
		#make boxes
		if boxes_struct
			_.each(boxes_struct, (i)->make_layout(i))
		#render alg
		render_alg()
		# color boxes
		set_boxes_colors()
		# zero counter for next run
		window.counter=0
		
	# hides a copy of the alg structure
	$(".hide").hide()
	
	# actually get the struc and renders it
	alg_name=_.last(window.location.pathname.split("/"))	
	z=$.get("/ajax_text_indent/#{alg_name}",(text_indent)->initial_layout(text_indent))





	

	


	





