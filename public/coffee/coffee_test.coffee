# this does a lot of stuff

$(document).ready =>

	window.rectangles=[]
	grid=20
	
	make_rect=(evt)->
		evt.stopPropagation()
		evt.preventDefault() 
		b=$("#containment-wrapper")
		
		text_box=$("<div class='ui-widget-content selectable text_box' style='position: absolute'> TEST</div>")
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
	
	render_alg=()->
		result=alg_text(sort_rect())
		alert(result)
		z=$.post("/view_text",{"text":result},(data)->$("#results").html(data))
	
		
	$(document).bind('keydown', 'Return', (evt)->make_rect(evt))
	$(document).bind('keydown', 'Ctrl+e', enter_text)
	z=0

	sort_rectb=()->
		alert([1,2,3,4,3])
	
	$("#tabs").tabs()
	$("#new_entry").bind 'click', make_rect
	$("#del_entry").bind 'click', del_entry
	$("button").button()
	$("#pos_calc").bind 'click',()->render_alg()
	$(".selectable").selectable({"selected":chosen, "unselected":unselected})
	$(".draggable").draggable()
	a=$('.alert').css("color","yellow")
	$('.alert').bind 'click',(event)->alert "ORCA"



# toogling
	# $(".hide_edit").hide()
	# $("#view_view").click(()=> 
	# 	$(".hide_edit").toggle() 
	# 	z=not z
	# 	$("#view_view").html("HIDE HERE") if z
	# 	$("#view_view").html("SHOW HERE") if not z
	# 	)
	# 	







