$(document).ready =>
	# GLOBALS
	window.debug=false
	window.graph_large=false
	
	
	# bar and tabs
	$("#accordion").accordion()
	$(".ui-accordion-content")[0].style.height="40px"
	$(".ui-accordion-content")[1].style.height="320px"
	$(".ui-accordion-content")[3].style.height="40px"
	
	$("#submit").button()
	$("#submit").click(()->$("form").submit())
	
	#accordion open on text edit
	$("#accordion").accordion("activate",2)

	
	resize=()->
		if not window.graph_large
			$("#text_graph_image").removeClass("text_graph_image_small")
			$("#text_graph_image").addClass("text_graph_image_large")
			window.graph_large=true
		else
			$("#text_graph_image").removeClass("text_graph_image_large")
			$("#text_graph_image").addClass("text_graph_image_small")
			window.graph_large=false
	
	#rendering of the png files
	render_inline=(data)->
		anchor=$("#text_graph")
		anchor.html("<img id=text_graph_image class=text_graph_image_small src=#{data.png} style='opacity:0.9;z-index:10000'></img>")
		$("#text_graph").show()
		$("#text_graph").click(resize)
		
	
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