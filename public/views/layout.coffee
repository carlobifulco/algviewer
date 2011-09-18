#USER CHECK
#------------
#placed in layout and called for every page
#if not true JSON from /user
#redirects to /login
# login info contained in localStorage for eaxh web page on the browser side
#information is sent unencrypted



redirect_to_login=()->
	window.location.href="/login"  unless _.last(window.location.pathname.split("/"))=="login" 

check_result=(r)->
	#alert(r.ok)
	if r.ok==false or r.ok=="false"
		#unless to avoid ethernal login loop
		console.log( _.last(window.location.pathname.split("/")))
		redirect_to_login() unless _.last(window.location.pathname.split("/"))=="login" 
		



# post '/user/:username' do
# user=params["username"]
# password=params["password"]




window.redirect_to_login=redirect_to_login


#LOGIN LOGIC; CHECKED FOR EVERY PAGE . NOT SURE THIS MAKES SENSE...
user=localStorage.user
password=localStorage.password

#actual call check status
#does not apply the login to the test URL
check_login=()->
  $.post("/user/#{user}",{"password":password,"type":"json"}).fail(redirect_to_login).done((r)->check_result(r)) unless _.last(window.location.pathname.split("/"))=="test" 
  

$(document).ready =>
  check_login()
