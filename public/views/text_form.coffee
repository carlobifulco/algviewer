$(document).ready =>
	# GLOBALS
	window.debug=false
	window.graph_large=false
	
	#UI SETUP
	#---------
	
	# bar and tabs
	$("#accordion").accordion()
	$(".ui-accordion-content")[0].style.height="30px"
	$(".ui-accordion-content")[1].style.height="320px"
	$(".button").button()
	$("#go_home").click(()->window.location.href="/" )
	$("#submit").button()
	$("#submit").click(()->$("form").submit())
	
	#accordion open on text edit
	$("#accordion").accordion("activate",2)

	
	#Image enlarging
	#---------------- 
	# binding on image click
	resize=()->
		if not window.graph_large
			$("#text_graph_image").removeClass("text_graph_image_small")
			$("#text_graph_image").addClass("text_graph_image_large")
			window.graph_large=true
		else
			$("#text_graph_image").removeClass("text_graph_image_large")
			$("#text_graph_image").addClass("text_graph_image_small")
			window.graph_large=false
	
	#text area resizing
	text_resize=()->
		lines_number=$("#edit").val().split("\n").length
		if lines_number<40 then lines_number=40
		$("#edit").attr("rows", lines_number+10)
		$("#accordion").accordion("resize")
	window.text_resize=text_resize

	
	# AJAX error visualization
	#--------------------------
	# replaces img entry with img 
	show_mistake=(error_obj)->
		window.error_obj=error_obj
		if window.debug
			$('#text_graph').html(error_obj.responseText)
		else
			$('#text_graph').html("<h3>ERROR IN YOUR GRAPH STRUCTURE. PLEASE FIX YOUR BOXES POSITION!!!</h3")
			

		
	window.show_mistake=show_mistake
			
	# error=(datapop...)->
	#  	alert("ERROR IN YOUR GRAPH STRUCTURE. PLEASE FIX YOUR BOXES POSITION!!!")
	# 	if datapop
	# 		alert(datapop)
	# 	
		
	
	#Graph Updating
	#---------------
	
	$('#text_graph').ajaxError((o,e)->show_mistake(e))
	
	# update call; set text; then rendered inline
	update_graph=()->
		set_text()
	
	#update graph button
	$('#update_graph_button').button().click( (evt)->update_graph(); false)
	
	#rendering of the png files
	render_inline=(data)->
		anchor=$("#text_graph")
		anchor.html("<img id=text_graph_image class=text_graph_image_small src='#{data}' style='opacity:0.9;z-index:10000'></img>")
		$("#text_graph").show()
		$("#text_graph").click(resize)
			
	
	#REST CALLS
	#-----------
	
	#save text in redis, also update graph
	# if error no saving
	set_text=()->
		#post '/yaml/:form_name' do
		#user_name=params[:user_name]
	  #content=params[:content]
		alg_name=_.last(window.location.pathname.split("/"))
		text=$("#edit").val()
		user=localStorage.user
		url="/text/#{alg_name}"
		$.post(url,{"user_name":user,"content":text}).success((e)->render_inline(e.png); text_resize(); $("#accordion").accordion("resize"))
	
	#enter textform text
	get_text=()->
		#get '/yaml/:form_name' do
	  #form_name=params[:form_name]
	  #user_name=params[:user_name]
		user=localStorage.user
		alg_name=_.last(window.location.pathname.split("/"))
		url="/text/#{alg_name}"
		$.get(url,{"user_name":user}).success((e)->$("#edit").val(e);text_resize(); $("#accordion").accordion("resize"))
	
	#Initiate
	#--------	

	get_text()
	text_resize()
		
		
	window.get_text=get_text
	window.set_text=set_text
	