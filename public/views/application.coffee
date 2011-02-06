
 a=$('.alert').css("color","yellow")
 $('.alert').bind 'click',(event)->alert "ORCA"
 $("#hide_edit").hide()
 $("#view_view").click(()->
 $("#hide_edit").toggle() 
 $("#view_view").html("hide stuff"))