
$(document).ready(()->
	z=0
	rectangles=[]
	
	a=$('.alert').css("color","yellow")
	$('.alert').bind 'click',(event)->alert "ORCA"
	$("#hide_edit").hide()
	$("#view_view").click(()=> 
		$("#hide_edit").toggle() 
		z=not z
		$("#view_view").html("HIDE HERE") if z
		$("#view_view").html("SHOW HERE") if not z
		)
		
	$("#draggable").draggable
	paper = Raphael(	$("#raphael")[0], 800, 800)
	paper.draggable.enable()
	set = paper.set()
	set.draggable.enable()
	
	circle = paper.circle(300, 200, 50).draggable.enable()
	rect=paper.rect(1, 1, 200, 100, 10).draggable.enable()
	rect2=paper.rect(300, 300,100, 100,10).draggable.enable()
	circle2 = paper.circle(300, 200, 30).draggable.enable()
	set.push(rect)
	set.push(circle)
	set.push(circle2)
	t=paper.text(300,300,"BODINI CICKS BUTT")
	t.attr("fill":"blue")
	rect.attr("fill","#FFF")
	$(rect.node).click(()=>rect.attr("fill","red"))
	circle.attr("fill","yellow")
	$(circle.node).click(()=>circle.animate({"cx":20, "r":20}, 2000))
	rect.node.mouseover=(event)=>
		alert("alarm")
	window.rect=rect	
	
	control_d=()=>
		alert("YOU PRESSED CONTROL D"+rectangles)
		p=paper.rect(0, 0, 200, 50).draggable.enable()
		rectangles.push(p)
		p
		
	$(document).bind('keydown', 'ctrl+d', control_d)
	a=control_d()
	a.draggable.enable()

	
	)






