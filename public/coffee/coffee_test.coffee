
$(document).ready =>

	window.rectangles=[]
	
	make_rect=()->
		b=$("#containment-wrapper")
		
		text_box=$("<div class='ui-widget-content selectable text_box' style='position: absolute'> TEST</div>")
		a=text_box.draggable({"grid":[20,20],"opacity":0.35,"refreshPositions":"true","containment":"parent"}).appendTo(".new_box")
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
		
	get_pos=(text_box)->
		$(text_box).position().top
	window.get_pos=get_pos
	
	sort_rect=()->
		a=get_pos(text_box) for text_box in $(".text_box")
		alert(a)
		return a
	window.sort_rect=sort_rect
		
	$(document).bind('keydown', 'Ctrl+n', make_rect)
	$(document).bind('keydown', 'Ctrl+e', enter_text)
	z=0

	sort_rectb=()->
		alert([1,2,3,4,3])

	$("button").button()
	$("button").bind 'click',(event)->sort_rect()
	$(".selectable").selectable({"selected":chosen})
	$(".draggable").draggable()
	a=$('.alert').css("color","yellow")
	$('.alert').bind 'click',(event)->alert "ORCA"

	$(".hide_edit").hide()
	$("#view_view").click(()=> 
		$(".hide_edit").toggle() 
		z=not z
		$("#view_view").html("HIDE HERE") if z
		$("#view_view").html("SHOW HERE") if not z
		)
		







