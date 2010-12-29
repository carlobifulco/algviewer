$(document).ready =>

	window.debug=false
	# bar and tabs
	$("#accordion").accordion()
	$(".ui-accordion-content")[0].style.height="40px"
	$(".ui-accordion-content")[1].style.height="320px"
	$(".ui-accordion-content")[3].style.height="40px"
	
	$("#submit").button()
	$("#submit").click(()->$("form").submit())
	
	#accordion open on text edit
	$("#accordion").accordion("activate",2)

	
	
	#inline graph resize function
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
	
	#rendering of the png files
	render_inline=(data)->
		anchor=$("#inline_graph")
		anchor.html("<img id=graph src=#{data.png} style='opacity:0.9;z-index:10000'></img>")
		$("#inline_graph").show()
		resize_graph()
	
	# update call; ajax pist; then rendered inline above
	update_graph=()->
		result=$("#edit").val()
		z=$.post("/graphic_edit_view",{"text":result,"dataType":"json"},(data)->render_inline(JSON.parse(data)))
		return z
	
	#show graph on window load	
	update_graph()
		
	# error visualization
	show_mistake=(error_obj)->
		window.error_obj=error_obj
		if window.debug
			$('#inline_graph').html(error_obj.responseText)
		else
			$('#inline_graph').html("<h3>ERROR IN YOUR GRAPH STRUCTURE. PLEASE FIX YOUR BOXES POSITION!!!</h3")
			

		
	window.show_mistake=show_mistake
			
	# error=(datapop...)->
	#  	alert("ERROR IN YOUR GRAPH STRUCTURE. PLEASE FIX YOUR BOXES POSITION!!!")
	# 	if datapop
	# 		alert(datapop)
	# 	
		
	
	$('#inline_graph').ajaxError((o,e)->show_mistake(e))
			
	# binds return to graph update		
	$(document).bind('keydown', 'Return', (evt)->update_graph())
	window.update_graph=update_graph