## Max positions is ususally 5 or 10
## tot risk assumed to be 10%
## simmetric stop strategy 


#CONSTANT MAX LOSS IF EVERY POSITION GOES SOUTH
window.risk=0.1

$(document).ready =>
	
	# reads entries and returns them as a dict plus shuffesle some in localStorage
	data=()->
		p=0
		r={}
		r["capital"]=$("#capital")[0].value
		r["entry_price"]=$("#entry_price")[0].value
		r["exit_price"]=$("#exit_price")[0].value
		localStorage.setItem("capital",r["capital"])
		localStorage.setItem("exit_price",r["exit_price"])
		localStorage.setItem("entry_price",r["entry_price"])
		p=$(".positions")[0].value
		r["p"]=p
		localStorage.setItem("p",p)
	
		return r
	window.data=data
	
	#calculates stocks n basesd on positions capital at risk (position capital*risk) and max loss (entry -exit)
	#calculates upper exit based on simmetry
	show=(r)->
		capital=parseFloat(r["capital"])
		entry_price=parseFloat(r["entry_price"])
		exit_price=parseFloat(r["exit_price"])
		p=parseFloat(r["p"])
		
		upper_exit=entry_price+(entry_price-exit_price)
		$("#exit").html("Upper Exit Price: #{upper_exit}")
		
		
		$("#lower_exit").html("Lower Exit Price: #{exit_price}")
		
		stocks_number=((capital / p)*window.risk) / (entry_price-exit_price)
		$("#stocks_number").html("Stocks Number: #{parseInt(stocks_number)}")
		$("#results").show()
		
		
		
	#updates n if previously stored
	initialize=()->	
		$("#submit").click(()->show(data()); return false)
		capital=localStorage.getItem("capital")
		p=localStorage.getItem("p")
		$(".positions")[0].value=p
		$("#entry_price")[0].value=localStorage.getItem("entry_price")
		$("#exit_price")[0].value=localStorage.getItem("exit_price")
			
		$("#capital")[0].value=capital
		$("#results").hide()
		
	initialize()
	
	