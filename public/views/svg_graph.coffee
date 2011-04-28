# uses new_gallery form pic_drop.coffee

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
  # implementation of the facebox
  new_gallery(algname, id).show() 

# binding of the svg nodes
bind_nodes=()->
  nodes=$(".node")
  $(i).dblclick((e)=>show_node(e)) for i in nodes
window.bind_nodes=bind_nodes



$(document).ready ->
  bind_nodes()

