class Thumbs
  constructor:()->
    @user=localStorage.user
    @algname=$("algname")[0].id
    @html=[]
    $.when(@get_thumbs(),@get_images()).done(@show)
  make_html:(tuple_urls)=>
     thumb=tuple_urls[0]
     image=tuple_urls[1]
     @html.push "<a href=#{image}><img src=#{thumb}></img></a>"
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
    @html=@html.join " "
    $("#thumbs").append(@html).hide()
    
    
    # temp="
    # {{#images}}
    # <a href={{.}}>
    # {{/images}}
    # {{#thumbs}}
    # <img src={{.}}></img>
    #  {{/thumbs}}
    # </a> 
    #    
    # "
    # html=Mustache.to_html(temp,@data)
    console.log @html 
    
    
window.thumbs=Thumbs

show=(thumbs,images)=>
  r=JSON.parse r
  console.log (r)
  thumbs={thumbs:r}

  temp="
  {{#thumbs}}
  <a href={{.}}>
  <img src={{.}}></img>
  </a> 
  {{/thumbs}}
  "
  
  console.log(i) for i in r
  html=Mustache.to_html(temp,thumbs)
  $("#thumbs").append(html).hide()
  console.log html  

#this is called on click of SVG element
test=(e)=>
#$(i).dblclick((evt)=>new_gallery(_.last(window.location.pathname.split("/")),evt.srcElement.id).show()) for i in dropboxes
  #alert(e)
  console.log e


  nodes=$(".node")
  #"/​galleria/​tester/​d8d76e03141ed1cf0d5704df71efbfef"
  algname=$("algname")[0].id
  nodeid=e.id
  n=new_gallery(algname,nodeid)
  window.n=n
  #window.location.href="/galleria/#{algname}/#{nodeid}"
  

  
  
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

window.test=test