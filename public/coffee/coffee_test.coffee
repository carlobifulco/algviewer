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

$(document).ready =>

	# grid size GLOBALS
	grid=25
	x_start=grid*2
	y_start=(grid*4)+$(".new_box").position().top
	#y_new_box_start=y_start-(grid*2)
	# 


		
		# i=[[" Urine Cytology",0],[" Positive",1]...
		# places the boxes if needed
	
		#get all selected boxes

	#returns all selected boxes in order

# new text box

	new_box=(x,y,text,counter_id)->
		text_box=$("<div id='#{counter_id}' class='ui-widget-content ui-corner selectable text_box' style='position: absolute; left: #{x}px; top: #{y}px'>#{text}</div>")
		text_box.draggable({"grid":[grid,grid],"opacity":0.35,"refreshPositions":"true","scroll":true}).appendTo(".new_box")
		text_box.draggable("stop":offset)
		#text_box.draggable({stop:"render_alg"})
		return text_box

##### loads text	
	make_layout=(i)->
		text=i[0]
		x=x_start+(i[1]*grid)
		y=y_start+(window.counter*grid)
		new_box(x,y,text, window.counter)
		# text_box=$("<div id='#{window.counter}' class='ui-widget-content ui-corner selectable text_box' style='position: absolute; left: #{x}px; top: #{y}px'>#{text}</div>")
		# text_box.draggable({"grid":[grid,grid],"opacity":0.35,"refreshPositions":"true","containment":"parent","scroll":true}).appendTo(".new_box")
		# text_box.draggable("stop":offset)
		#text_box.selectable({stop:()->alert("AAAA")})
		window.counter+=1
	window.make_layout=make_layout

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

	#enters a new box 
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
		window.counter+=1
	
	#updates the text of a box
	enter_text=()->
		b=$(".ui-selected")[0]
		#alert(b)
		if b
			b.innerText=document.text_form.text_content.value
			document.text_form.text_content.value=""

	# css for when selected
	chosen=()->
		$(".text_box").css("color","black")
		$(".ui-selected").css("color","red")
		$(".ancor").css("color","black")
	
	#kills a box
	del_entry=()->
		$(".ui-selected").remove()
		yaml_structure=boxes_to_yaml()
		save(yaml_structure)

	#sorts the boxes so that they can get rendered in text in order
	sort_rect=()->
		text_boxes= $(".text_box")
		sorted_boxes=_.sortBy(text_boxes, get_pos) 
		window.sorted_boxes=sorted_boxes
		text_positions=(make_text_position(sorted_box) for sorted_box in sorted_boxes)
		window.text_positions=text_positions
		text_positions

	make_text_position=(text_box)->
		text=$(text_box).text()
		pos_left=$(text_box).position().left
		[text,pos_left]

##### Multiple dragging business	 
	
	# u is the dragged item; u.position.left and top is where it got dragged
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
	
	
	resize_graph=()->
		$($("img")[0]).load(()-> 
			w=$("img")[0].width
			h=$("img")[0].height
			unless (w<500 and h<500)
				r=w/h
				size=500
				if r>1
					$("img")[0].height=size/r
					$("img")[0].width=size
				if r<=1
						$("img")[0].width=size*r
						$("img")[0].height=size
			$($("img")[0]).show()
			)
		
	
	# inline rendering
	render_inline=(data)->
		anchor=$("#inline_graph")
		#data=JSON.parse(data)
		#yaml load and rest call; returns dictionary response
		window.z=data
		#alert(data["png"])
		
		anchor.html("<img class=inline_graph src=#{data.png}></img>")
		$("#inline_graph").show()
		#$("inline_graph").onclick()
		resize_graph()
		
	


	
	# transform the boxes in a yaml alg
	boxes_to_yaml=()->
		result=alg_text(sort_rect())
		# for debugging
		window.yaml=result
		return result
	window.boxes_to_yaml=boxes_to_yaml
		
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
	
	#keys bindings
	
	$(document).keyup((e)-> window.is_ctrl=false if e.keyCode==17)
	$("#text_entry").keydown((e)-> e.stopPropagation(); make_rect(e) if e.keyCode==13)
	# $(document).bind('keydown', 'Return', (evt)->make_rect(evt))
	# $(document).bind('keydown', 'Ctrl+e', enter_text)
	# $(document).bind('keydown', 'Ctrl+a', alert)
	z=0
	
	# bar and tabs
	$("#progressbar").progressbar("value":0)
	$("#tabs").tabs()
	
	
	text_edit=()->
		alg_name=_.last(window.location.pathname.split("/"))	
		window.location.href="/edit_text/#{alg_name}"

	
	# Buttons
	$("#home").bind 'click', ()->window.location.pathname="/"
	$("#new_entry").bind 'click', make_rect
	$("#del_entry").bind 'click', del_entry
	$("#text_edit").bind 'click', text_edit
	$("button").button()
	
	#draggables selectables
	$(".selectable").selectable({"selected":chosen, "unselected":unselected})
	$(".draggable").draggable()

	
	#graphic edit mode
	#alg structure is linked to the #hide_graphic_edit in the dom
	$(".hide").hide()
	window.a=eval($("#hide_graphic_edit").text())
	if window.a
		_.each(window.a, (i)->make_layout(i))
		window.counter=0
	
	#all selectable stop linked to function
	$(".selectable").selectable({stop:()->get_selected()})	
	
	#error log
	$('#error_log').ajaxError(()=>alert("ERROR IN YOUR GRAPH STRUCTURE. PLEASE FIX YOUR BOXES POSITION!!!"))
	
	# render on first load
	render_alg()

	handle_file_select=(evt)->
	  evt.stopPropagation()
	  evt.preventDefault()
	  files=evt.dataTransfer.files
	  alert(files)
	window.handle_file_select=handle_file_select
	
	handle_drag_over=(evt)->
		alert("DRAGGED OVER")

	
	# test=()->
	#   	d = $('#content')[0]
	# 	return d
  # $("drop_zone").bind('dragover', handle_drag_over, false)
  # #drop_zone.addEventListener('drop', handle_file_select, false)
  # window.drop_zone=drop_zone
 		#alert(drop_zone)

	# window.test=test
	
	#alert ("TEST")



# toogling
	# $(".hide_edit").hide()
	# $("#view_view").click(()=> 
	# 	$(".hide_edit").toggle() 
	# 	z=not z
	# 	$("#view_view").html("HIDE HERE") if z
	# 	$("#view_view").html("SHOW HERE") if not z
	# 	)
	# 	







