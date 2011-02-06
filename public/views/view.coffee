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
	_.each($(".small_acc"),(e)-> e.style.height="40px")
	
	
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
			dfd = $.Deferred()
			graph_name="/yaml/#{@graph_name}"
			$.get(graph_name,{"user_name":@user_name, type:"ajax"},(e)=>@yaml_text=JSON.stringify(e);dfd.resolve())
			return dfd.promise()
		graph:()=>
			$.get("/graph",{"colors_hash":@color_hash,"yaml_text":@yaml_text, type:"ajax"},(e)=>@urls=JSON.parse(e);@update_urls(@urls))
		get_graph:()=>
			$.when(@yaml(),@colors()).done(@graph)	
		show:(urls)=>
			alert(urls.pdf)
		update_urls:(urls)=>
			$(".pdf").attr("href","http://#{urls.pdf}")
			$(".png").attr("href","http://#{urls.png}")
			$(".dot").attr("href","http://#{urls.dot}")
			$(".svg").attr("href","http://#{urls.svg}")
			$("src").attr("src","http://#{urls.png}")
		
	# 
	# get_graph=(alg_name)->
	# 	g=new GraphUrls(alg_name)
	# 	$.when(g.colors(),g.yaml()).then(()->graph())
		
		
		
		
		
	# window.colors=colors
	# window.yaml=yaml
	# window.graph=graph
	# window.get_graph_urls=get_graph_urls
	window.GraphUrls=GraphUrls
	g=new GraphUrls(alg_name)
	g.get_graph()
	#window.get_graph=get_graph
	
	# loads urls of graphs
	# get_graph_urls(alg_name)

	
	
	
	
	