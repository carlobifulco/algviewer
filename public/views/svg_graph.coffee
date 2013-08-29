# uses new_gallery form pic_drop.coffee

parent_attr=(e)->
  if e.srcElement
    n=$(e.srcElement.parentNode)
  else
    n=$(e.target.parentNode)
  algname= n.attr("algname")
  id= n.attr("id")
  user=n.attr("user")
  console.log [algname,id,user]
  return [algname,id, user]


show_node=(e)->
  # console.log "I AM #{e.currentTarget.textContent}"
  console.log "node is"
  console.log e
  text=e.currentTarget.textContent
  algname_id=parent_attr(e)
  algname=algname_id[0]
  id=algname_id[1]
  user=algname_id[2]
  # implementation of the facebox
  console.log text
  console.log "calling gallery with #{algname}, #{id},  #{text} and #{user}"
  n=new_gallery(algname, id, text, user)
  console.log n
  n.show()

# binding of the svg nodes
bind_click=()->
  nodes=$(".node")
  $(i).dblclick((e)=>show_node(e)) for i in nodes
window.bind_click=bind_click

color=(e,color_old,color_new)->
  algname_id=parent_attr(e)
  algname=algname_id[0]
  id=algname_id[1]
  user=algname_id[2]
  console.log " #{id} pos #{_.indexOf(window.nodes_with_images,id)} in #{window.nodes_with_images}"
  # if the node is in the list of nodes with images then
  if (_.indexOf(window.nodes_with_images,id)) != -1
    console.log "HURRAY"
    nodes=e.currentTarget.childNodes
    a=[]
    # all childnodes of event that have old color
    a.push(i) for i in nodes when ($(i).css("fill")==color_old)
    console.log a
    #swith their color
    $(i).css("fill",color_new) for i in a
    console.log a


bind_hover=()->
  $(".node").mouseenter((e)-> color(e,"#ffeecc","#ffff00")).mouseleave((e)-> color(e,"#ffff00","#ffeecc"))
  #$(".node").mouseenter((e)-> alert e; no_text(e.currentTarget.childNodes))
  #$(".node polygon").mouseenter((e)->$(e.srcElement).css("fill","yellow")).mouseleave((e)->$(e.srcElement).css("fill","#ffeecc"))
  #$(".node text").mouseenter((e)->$(e.srcElement).css("fill","yellow")).mouseleave((e)->$(e.srcElement).css("fill","black"))
  #$(".node polyline").mouseenter((e)->$(e.srcElement).css("fill","yellow")).mouseleave((e)->$(e.srcElement).css("fill","black"))
window.bind_hover=bind_hover



$(document).ready ->

  algname=$($(".node")[0]).attr("algname")

  url="/nodes_with_images/#{window.location.pathname.split("/")[2]}/#{algname}"
  # window.nodes_with_images contaisn list of nodes with pics
  $.get(url,(r)->window.nodes_with_images=JSON.parse(r))
  bind_click()
  bind_hover()
  #prevent text selection
  document.body.onselectstart=()->return false


