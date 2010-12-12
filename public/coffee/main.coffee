# this does a lot of stuff



# javascript 
# 45		
# 46		  $(document).ready(function(){
# 47		
# 48		    $("#dialog").dialog({
# 49		         autoOpen: false,
# 50		         modal: true
# 51		       });
# 52		
# 53		  $("#view_view").click(function(){
# 54		    $("#hide_view").toggle();
# 55		  });
# 56		
# 57		  $("#hide_edit").hide();
# 58		  $("#view_edit").click(function(){
# 59		    $("#hide_edit").toggle();
# 60		  });
# 61		
# 62		  $("#hide_delete").hide();
# 63		  $("#view_delete").click(function(){
# 64		    $("#hide_delete").toggle();
# 65		  });
# 66		
# 67		
# 68		  $(".confirmLink").click(function(e) {
# 69		     e.preventDefault();
# 70		     var targetUrl = $(this).attr("href");
# 71		
# 72		     $("#dialog").dialog({
# 73		       buttons : {
# 74		         "Confirm" : function() {
# 75		           window.location.href = targetUrl;
# 76		         },
# 77		         "Cancel" : function() {
# 78		           $(this).dialog("close");
# 79		         }
# 80		       }
# 81		     });
# 82		
# 83		     $("#dialog").dialog("open");
# 84		   });
# 85		  });

$(document).ready =>


## MENU STAFF HERE show and hide
	$("#view_view").click(()->$("#hide_view").toggle())
	$("#hide_edit").hide()
	$("#view_edit").click(()->$("#hide_edit").toggle())
	$("#hide_delete").hide()
	$("#view_delete").click(()->$("#hide_delete").toggle())
	$("#hide_graphic_edit").hide()
	$("#view_graphic_edit").click(()->$("#hide_graphic_edit").toggle())
	
## sets dialog buttons and action
	confirm_link=(e)=>
		window.e=e
		e.preventDefault()
		target_url=e.srcElement.href
		$("#dialog").dialog({buttons :[{text:"Confirm","click":()->window.location.href=target_url},{text:"Cancel","click":()->$("#dialog").dialog("close")}]})
		$("#dialog").dialog("open")
		
		
## Delete confirm alert
	$("#dialog").dialog({"autoOpen":"false","modal":"true"})
	$("#dialog").dialog("close")
	$(".confirmLink").bind("click",(e)=>confirm_link(e))
	
## Accordion
	$( "#accordion" ).accordion()

## Button
	check_entry=()->
		v=$("#entry")[0].value
		if v == ""
			alert("no entry")
			return false
		else
			window.location.href="/edit_text/#{v}"
			
			
	$("#button").click((e)->check_entry())
	$("#button").button()
	$("#button2").button()

	
	







