##

$(document).ready =>

	window.rectangles=[]
	grid=20
	x_start=40
	y_start=60+$(".new_box").position().top
	window.counter=0
	
	# i=[[" Urine Cytology",0],[" Positive",1]...
	make_layout=(i)->
		text=i[0]
		x=x_start+(i[1]*grid)
		y=y_start+(window.counter*grid)
		text_box=$("<div class='ui-widget-content selectable text_box' style='position: absolute; left: #{x}px; top: #{y}px'>#{text}</div>")
		text_box.draggable({"grid":[20,20],"opacity":0.35,"refreshPositions":"true","containment":"parent"}).appendTo(".new_box")
		window.counter+=1
		
	window.make_layout=make_layout
	make_rect=(evt)->
		evt.stopPropagation()
		evt.preventDefault() 
		b=$("#containment-wrapper")
		
		text_box=$("<div class='ui-widget-content selectable text_box' style='position: absolute; left: 40px'> TEST</div>")
		text_box.draggable({"grid":[20,20],"opacity":0.35,"refreshPositions":"true","containment":"parent"}).appendTo(".new_box")
		new_text=document.text_form.text_content.value 
		#alert(new_text)
		text_box.html(document.text_form.text_content.value) if new_text
		document.text_form.text_content.value=""
		window.rectangles.push(a)
		window.last=a
	
	enter_text=()->
		b=$(".ui-selected")[0]
		#alert(b)
		if b
			b.innerText=document.text_form.text_content.value
			document.text_form.text_content.value=""
	
	chosen=()->
		$(".text_box").css("color","black")
		$(".ui-selected").css("color","red")
		$(".ancor").css("color","black")
		
	del_entry=()->
		$(".ui-selected").remove()
		#alert("Killed this sucker")

	unselected=()->
		chosen()
		
	get_pos=(text_box)->
		$(text_box).position().top
	window.get_pos=get_pos
	
	sort_rect=()->
		text_boxes= $(".text_box")
		sorted_boxes=_.sortBy(text_boxes, get_pos) 
		window.sorted_boxes=sorted_boxes
		text_positions=make_text_position(sorted_box) for sorted_box in sorted_boxes
		window.text_positions=text_positions
		text_positions
		
	make_text_position=(text_box)->
		text=$(text_box).text()
		pos_left=$(text_box).position().left
		[text,pos_left]
		
	alg_text=(text_positions)->	 
		text="\n"
		baseline=text_positions[0][1]
		for text_position in text_positions
			offset=text_multiply("  ",(text_position[1]-baseline)/grid)
			if offset>old_offset
				text+=old_offset+"-"+"\n"
			if text_position[1]==baseline
				text+="\n"
			text+=(offset+"- "+ text_position[0] +"\n")
			old_offset=offset
		text
	window.alg_text=alg_text
		
	text_multiply=(text,n)->
		a=[]
		for i in [0...n] 
			a.push(text)
		a.join("")
	window.text_multiply=text_multiply
	
	rendering_ok=(data)->
		$("#results").append(data)
		$("#progressbar" ).progressbar("value": 100)

		$("#progressbar" ).progressbar("value": 0)
		#$("img")[0].height=300
		#$("img")[0].width=$("img")[0].height*ratio
		$("#hide_me").hide()
		$($("img")[0]).hide()
		$("#tabs").tabs("destroy")
		$("#tabs").tabs()
		$("#tabs").tabs("select","tabs-2")
		$($("img")[0]).load(()-> 
			r=$("img")[0].width/$("img")[0].height
			$("img")[0].height=400
			$("img")[0].width=400*r
			$($("img")[0]).show()
			)
	render_alg=()->
		result=alg_text(sort_rect())
		#alert(result)
		$("#progressbar" ).progressbar("value":25)
		z=$.post("/view_text",{"text":result},(data)->rendering_ok(data))
	


	
		
	$(document).bind('keydown', 'Return', (evt)->make_rect(evt))
	$(document).bind('keydown', 'Ctrl+e', enter_text)
	z=0

	sort_rectb=()->
		alert([1,2,3,4,3])
	$("#progressbar").progressbar("value":0)
	$("#tabs").tabs()
	$("#new_entry").bind 'click', make_rect
	$("#del_entry").bind 'click', del_entry
	$("button").button()
	$("#pos_calc").bind 'click',()->render_alg()
	$(".selectable").selectable({"selected":chosen, "unselected":unselected})
	$(".draggable").draggable()
	$("#hide_graphic_edit").hide()
	a=$('.alert').css("color","yellow")
	$('.alert').bind 'click',(event)->alert "ORCA"
	window.a=eval($("#hide_graphic_edit").text())
	if window.a
		_.each(window.a, (i)->make_layout(i))
		window.counter=0
		
	
		


# toogling
	# $(".hide_edit").hide()
	# $("#view_view").click(()=> 
	# 	$(".hide_edit").toggle() 
	# 	z=not z
	# 	$("#view_view").html("HIDE HERE") if z
	# 	$("#view_view").html("SHOW HERE") if not z
	# 	)
	# 	







