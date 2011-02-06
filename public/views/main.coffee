
$(document).ready =>





#Auth Business
#---------------

	
	#check if user in local storage. if not present, open dialog
	# if present, check credentials. if mismatch, open dialog vial check_local_storage
	who_are_you=()->
		if not localStorage.getItem("user")
			check_user_dialog()
		else
			user=localStorage.user
			pw=localStorage.password
			params={'user':"#{user}",'password':"#{pw}"}
			r=$.post('/check_user',params,check_local_storage,"json")



	#open modal dialog and bind to check_auth
	check_user_dialog=()->
		$( "#dialog-form" ).dialog({"autoOpen": false,"height": 300,"width": 350, "modal": true})
		$("#create-user").button()
		$("#dialog-form").dialog("open")
		$("#dialog-form").dialog({"closeOnEscape":false,close:()->$("#dialog-form").dialog("open")})
		$("#create-user").click((e)->check_auth(); return false)
		
	#takes server reply to dialog entries or to local storage items
	check_local_storage=(r)->
		if r=="OK"
			$("#dialog-form").hide()
		else
			check_user_dialog()

		
# check auth
	check_auth=()-> 
		update=(r)->
			user=$("#user")[0].value
			pw=$("#password")[0].value
			if r=="OK"
				localStorage.user=user
				localStorage.password=pw
				window.location.url="/"
				$("#dialog-form").dialog("destroy")
			else
				alert("Incorrect User or Password")
				window.location.url="/"
				return false
		user=$("#user")[0].value
		pw=$("#password")[0].value
		params={'user':"#{user}",'password':"#{pw}"}
		#call check_user
		r=$.post('/check_user',params,update,"json")
		window.r=r
		
 #Logout user
	logout=()->
		localStorage.user=false
		localStorage.password=false
		window.location.reload()
		

#GUI
#---		


## MENU STAFF HERE show and hide
	$("#view_view").click(()->$("#hide_view").toggle())
	$("#hide_edit").hide()
	$("#view_edit").click(()->$("#hide_edit").toggle())
	$("#hide_delete").hide()
	$("#view_delete").click(()->$("#hide_delete").toggle())
	$("#hide_graphic_edit").hide()
	$("#view_graphic_edit").click(()->$("#hide_graphic_edit").toggle())
	

		
		


	
## Accordion
	$( "#accordion" ).accordion()
	# size small accordions entries
	_.each($(".small_acc"),(e)-> e.style.height="40px")
	_.each($(".int_acc"),(e)-> e.style.height="80px")

## Button
	check_entry=(r)->
		s="#entry#{r}"
		v=$(s)[0].value
		if v == ""
			alert("no entry")
			return false
		else
			return true
	window.check_entry=check_entry
	
	check_autocomplete=(r)->
		s="#autocomplete"
		v=$(s)[0].value
		if v == ""
			alert("No entry; please enter a new name or select or select an existing graph")
			return false
		else
			return v
	window.check_entry=check_entry
	
	# checks text in the autocompletion field. if not opens mathcing accordion
	# else is sends to mathing alg web page
	no_entry_open_accordion=(n)->
		entry=$("#autocomplete")[0].value 
		if not entry
			$("#accordion").accordion("activate",n) 
			return false
		else
			entry
		
			
	delete_dialog=(url,filename)->
		$("#delete").dialog({buttons :[{text:"Confirm Delete #{filename}","click":()->window.location.href=url},{text:"Cancel","click":()->$("#delete").dialog("close")}]})
		$("#delete").dialog("open")
		
		
	# 	/ DIALOGS
	# 
	# login_dialog=()->
	# 	$('#login').dialog()
	# 	%div{:id=>"dialog-form", :title=>"Please enter username and password"}
	# 	  %form{:action=>"/"}
	# 	    %fieldset
	# 	      %label{:for=>'user'}
	# 	        User Id
	# 	      %input{:type=>"text", :name=>"user", :id=>"user", :class=>"text ui-widget-content ui-corner-all"}
	# 	      %label{:for=>'password'}
	# 	        Password
	# 	        %input{:type=>"text", :name=>"password", :id=>"password", :class=>"text ui-widget-content ui-corner-all"}
	# 	    %button#create-user
	# 	      Check Authorization
		
		
	## sets dialog buttons and action
	confirm_link=(e)=>
		window.e=e
		e.preventDefault()
		target_url=e.srcElement.href
		$("#delete").dialog({buttons :[{text:"Confirm","click":()->window.location.href=target_url},{text:"Cancel","click":()->$("#delete").dialog("close")}]})
		$("#delete").dialog("open")

	
	#GUI bindings
	#-------------		
	$("#text_edit_button").click((e)->window.location.href="/edit_text/#{$("#entry1")[0].value}" if check_entry(1))
	$("#graph_edit_button").click((e)->window.location.href="/graphic_edit/#{$("#entry2")[0].value}" if check_entry(2))
	$("#text_edit_button2").click((e)->entry=no_entry_open_accordion(2); window.location.href="/edit_text/#{entry}" if entry)
	$("#graph_edit_button2").click((e)->entry=no_entry_open_accordion(3); window.location.href="/graphic_edit/#{entry}" if entry)
	$("#delete_button2").click((e)->entry=no_entry_open_accordion(4); delete_dialog("/delete/#{entry}",entry)  if entry)
	$("#view_button_2").click((e)->entry=no_entry_open_accordion(1); window.location.href="/view/#{entry}" if entry)
	$("#logout").click(logout)
		

	$("#button").button()
	$("#button2").button()
	$(".button").button()

	$("#all_algs_names").hide()
	window.alg_names=eval($("#all_algs_names").text())
	$( "#autocomplete" ).autocomplete({"source": window.alg_names})
	
	
	
	
	
	# RUN the Auth stuff
	#--------------------
	who_are_you()
	
	#Template main page
	#-------------------
	
	
	
	template_alg_names=(graph_names_list)->
	  markdown_list=[]
	  _.each(graph_names_list,(graph_name)->markdown_list.push({"graph_name":graph_name}))
	  return markdown_list
	  
	insert_template=(template)->
	  $("#text_edit").append($("#edit_text_template").tmpl(template))
	  $("#view").append($("#view_template").tmpl(template))
	  $("#graphic_edit").append($("#graphic_edit_template").tmpl(template))
	  $("#delete").append($("#delete_template").tmpl(template))
	
	#get graph names
	$.get("/alg_names/#{localStorage.user}",(r)->insert_template(template_alg_names(JSON.parse(r))))
	
	
	
	#BINDINGS
	window.template_alg_names=template_alg_names
	window.insert_template=insert_template
	
	
	## Delete confirm alert
	$(".confirmLink").bind("click",(e)=>confirm_link(e))
	
	# %a{:href=>"/view/#{x}"}=x
	# %a{:href=>"/edit_text/#{x}"}=x
	# %a{:href=>"/graphic_edit/#{x}"}=x
	
	
	
	
		


	
	







