$(document).ready =>
	
  colorme=(color)->
    console.log(color.color)
    r= Math.round(color.color.rgb[0]*255)
    g= Math.round(color.color.rgb[1]*255)
    b= Math.round(color.color.rgb[2]*255)
    console.log JSON.stringify([r,g,b])
    result="rgb(#{r}, #{g}, #{b})"
    console.log result
    return color
  window.colorme=colorme
  