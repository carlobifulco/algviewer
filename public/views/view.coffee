$(document).ready =>
	$("#accordion").accordion()
	$(".links").button()
	
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
		$(".ui-accordion-content")[0].style.height="#{$('img')[0].height}px"
		)
		
	alg_name=_.last(window.location.pathname.split("/"))
	user_name=localStorage.user
	$("#title").html(alg_name)
	$($("img")[0]).hide()
	
	# size small accordions entries
	_.each($(".small_acc"),(e)-> e.style.height="100px")
	
	# get colors
	colors=JSON.parse(localStorage.getItem(alg_name))
	
	
		
	#Getting a graph RESTFUL
	#----------
	# object calls need to be preceeded by @
	# Deffered(), resolve, promise
	#get_graph_urls starts list of RESTful calls  --colors, yaml and graph
	class GraphUrls
		constructor:(graph_name)->
			@user_name=localStorage.user
			@graph_name=graph_name
		colors:()=>
			dfd = $.Deferred()
			@colors_url="/nodes_colors/#{@graph_name}"
			$.get(@colors_url,{"user_name":@user_name, type:"ajax"},(e)=>@color_hash=e;dfd.resolve())
			return dfd.promise()
		yaml:()=>
			#called first; execution is hold till @yaml_text is assigned
			dfd = $.Deferred()
			graph_name="/yaml/#{@graph_name}"
			$.get(graph_name,{"user_name":@user_name, type:"ajax"},(e)=>@yaml_text=JSON.stringify(e);dfd.resolve())
			return dfd.promise()
		graph:()=>
		  # had to change to psot because of ?firewall issues
		  
			$.post("/graph",{"colors_hash":@color_hash,"yaml_text":@yaml_text, type:"ajax","algname":@graph_name},(e)=>@urls=JSON.parse(e);@update_urls(@urls); $("#temp").hide())
			$.post("/graph",{"yaml_text":@yaml_text, type:"ajax","algname":@graph_name},(e)=>@mono_urls=JSON.parse(e);@update_mono(@mono_urls))
			$.post("/graph",{"colors_hash":@color_hash, "options":JSON.stringify({"circle":"1"}),"yaml_text":@yaml_text, type:"ajax","algname":@graph_name},(e)=>@mono_urls=JSON.parse(e);@update_circle(@mono_urls))
			#the last laso updates size of accordion
			$.post("/graph",{"colors_hash":@color_hash, "options":JSON.stringify({"ellipse":"1"}),"yaml_text":@yaml_text, type:"ajax","algname":@graph_name},(e)=>@mono_urls=JSON.parse(e);@update_ellipse(@mono_urls); $("#accordion").accordion("resize"))
		get_graph:()=>
			#when yaml and colors are taken care it will execute graph
			$.when(@yaml(),@colors()).done(@graph)	
		show:(urls)=>
			alert(urls.pdf)
		update_urls:(urls)=>
			$(".pdf").attr("href","#{urls.pdf}")
			$(".png").attr("href","#{urls.png}")
			$(".dot").attr("href","#{urls.dot}")
			$(".svg").attr("href","#{urls.svg}")
			#preview
			$("#preview").attr("src","#{urls.png}")
		update_mono:(urls)=>
			$(".mono-pdf").attr("href","#{urls.pdf}")
			$(".mono-png").attr("href","#{urls.png}")
			$(".mono-dot").attr("href","#{urls.dot}")
			$(".mono-svg").attr("href","#{urls.svg}")
		update_circle:(urls)=>
			$(".circle-pdf").attr("href","#{urls.pdf}")
			$(".circle-png").attr("href","#{urls.png}")
			$(".circle-dot").attr("href","#{urls.dot}")
			$(".circle-svg").attr("href","#{urls.svg}")
		update_ellipse:(urls)=>
			$(".ellipse-pdf").attr("href","#{urls.pdf}")
			$(".ellipse-png").attr("href","#{urls.png}")
			$(".ellipse-dot").attr("href","#{urls.dot}")
			$(".ellipse-svg").attr("href","#{urls.svg}")

	
	window.GraphUrls=GraphUrls
	g=new GraphUrls(alg_name)
	g.get_graph()


	
	
	
	
	