$(document).ready =>
	
  colorme=(color)->
    console.log(color.color.valueElement.value)
    alert color
    return color
  window.colorme=colorme
  