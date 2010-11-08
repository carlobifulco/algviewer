@@ application
$(document).ready(function(){

  $("#dialog").dialog autoOpen: false, modal: true

$("#view_view").click(function(){
  $("#hide_view").toggle
});

$("#hide_edit").hide
$("#view_edit").click(function(){
  $("#hide_edit").toggle();
});

$("#hide_delete").hide();
$("#view_delete").click(function(){
  $("#hide_delete").toggle();
});


$(".confirmLink").click(function(e) {
   e.preventDefault();
   var targetUrl = $(this).attr("href");

   $("#dialog").dialog({
     buttons : {
       "Confirm" : function() {
         window.location.href = targetUrl;
       },
       "Cancel" : function() {
         $(this).dialog("close");
       }
     }
   });

   $("#dialog").dialog("open");
 });
});
