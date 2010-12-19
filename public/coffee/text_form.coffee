$(document).ready =>
	# bar and tabs
	$("#accordion").accordion()
	$(".ui-accordion-content")[0].style.height="40px"
	$(".ui-accordion-content")[1].style.height="140px"
	$(".ui-accordion-content")[3].style.height="40px"
	
	$("#submit").button()
	$("#submit").click(()->$("form").submit())