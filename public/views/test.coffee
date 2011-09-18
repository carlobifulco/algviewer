# TEST
#_______

#This 

$(document).ready =>
  
  
  $.get "/yaml/test?user_name=tester",(e)=>
    console.log e
    o=
      yaml_text:JSON.stringify(e),
      type:"json",
      algname:"test",
      user_name:"tester"
      
    $.post "/graph",o,(r)=>
      r=JSON.parse r
      console.log r
      console.log r.svg
      console.log typeof r
      
      
      $("#svg").append("<a href=#{r.svg}> SVG</a>")
      
