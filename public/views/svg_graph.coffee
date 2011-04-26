class Thumbs
  constructor:()->
    @user=localStorage.user
    @algname=$("algname")[0].id
    @html=["<div rel=test>"]
    $.when(@get_thumbs(),@get_images()).done(@show)
  make_html:(tuple_urls)=>
    thumb=tuple_urls[0]
    image=tuple_urls[1]
    nodeid=image.split("/")[4]
    @html.push "<div class=#{nodeid} style='display:none;'​><a href=#{image} rel=facebox><img src=#{thumb}></img></a></div>"
  get_thumbs:()=>
    dfd = $.Deferred()
    url="/thumbs/#{@user}/#{@algname}"
    $.get(url,(r)=>@thumbs=JSON.parse(r); console.log @thumbs; dfd.resolve())
    return dfd.promise()
  get_images:()=>
    dfd = $.Deferred()
    url="/images/#{@user}/#{@algname}"
    $.get(url,(r)=>@images=JSON.parse(r); console.log @images; dfd.resolve())
    return dfd.promise()
  show:()=>
    data=_.zip(@thumbs,@images)
    @make_html(i) for i in data
    @html.push("</div>")
    @html=@html.join " "
    # attaches results to #thumbs 
    $("#thumbs").append(@html)
    console.log @html 
  show_html:()=>
    console.log @html
    
    
window.thumbs=Thumbs
# 
# show=(thumbs,images)=>
#   r=JSON.parse r
#   console.log (r)
#   thumbs={thumbs:r}
# 
#   temp="
#   <div rel=test>
#   {{#thumbs}}
#   <a href={{.}}>
#   <img src={{.}}></img>
#   </a> 
#   {{/thumbs}}
#   </div>
#   "
#   
#   console.log(i) for i in r
#   html=Mustache.to_html(temp,thumbs)
#   $("#thumbs").append(html).hide()
#   console.log html  

#this is called on click of SVG element
show_thumbs=(e)=>
#$(i).dblclick((evt)=>new_gallery(_.last(window.location.pathname.split("/")),evt.srcElement.id).show()) for i in dropboxes
  #alert(e)
  nodes=$(".node")
  #"/​galleria/​tester/​d8d76e03141ed1cf0d5704df71efbfef"
  algname=$("algname")[0].id
  nodeid=e.id
  console.log(nodeid)
  #all entries with class of nodeid
  thumbs=$(".#{nodeid}")
  
  if (thumbs.length > 0) 
    #clones them
    thumbs_clone=thumbs.clone()
    # to be deleted
    thumbs_clone.attr("class","temp")
    $(".temp a").attr("class","temp")
    thumbs_clone.show()
    console.log thumbs_clone
    #showing the thumbs here
    jQuery.facebox(thumbs_clone)
    
    console.log "> then 0"
  console.log (thumbs.length > 0)
  n=new_gallery(algname,nodeid)
  window.n=n
  # shows the images
  $('a[rel*=facebox]').facebox()
  
  #window.location.href="/galleria/#{algname}/#{nodeid}"
  
close_facebox=()->
  console.log ("closing")
  $(".temp a").attr("class","temp")
  console.log $(".temp")
  $(".temp").remove()
  
  
  #n.show()
  # console.log "algname detected #{algname}"
  #   ids=[]
  #   window.nodes_nodesids=[]
  #   ids.push(_.last(i.id.split("/"))) for i in nodes
  #   nodes_ids=_.zip(nodes,ids)
  #   console.log nodes_ids
  #   for node_id in nodes_ids
  #     do (node_id)=>
  #       $(node_id[0]).dblclick(alert(node_id))# new_gallery(algname,node_id[1]).show())
  #   #$(i).dblclick((evt,i)=>new_gallery(_.last(window.location.pathname.split("/")),i.id).show()) for i in nodes
  #   
  #   alert($("svg"))
  #   return e

#$.get("/thumbs/#{localStorage.user}/#{$("algname")[0].id}",(r)=>show(r))

parent_attr=(e)->
  n=$(e.srcElement.parentNode)
  algname= n.attr("algname")
  id= n.attr("id")
  console.log [algname,id]
  return [algname,id]
  
show_node=(e)->
  algname_id=parent_attr(e)
  algname=algname_id[0]
  id=algname_id[1]
  new_gallery(algname, id).show() 

bind_nodes=()->
  nodes=$(".node")
  $(i).dblclick((e)=>show_node(e)) for i in nodes
window.bind_nodes=bind_nodes

window.show_thumbs=show_thumbs
$(document).bind('afterClose.facebox',()->close_facebox())
thumbs=new Thumbs
window.thumbs=thumbs

$(document).ready ->
  bind_nodes()

