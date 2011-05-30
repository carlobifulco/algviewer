#USER CHECK
#------------
#placed in layout and called for every page
#if not true JSON from /user
#redirects to /login


user=localStorage.user
password=localStorage.password


redirect_to_login=()->
	window.location.href="/login"  unless _.last(window.location.pathname.split("/"))=="login" 

check_result=(r)->
	#alert(r.ok)
	if r.ok==false or r.ok=="false"
		#unless to avoid ethernal login loop
		console.log( _.last(window.location.pathname.split("/")))
		redirect_to_login() unless _.last(window.location.pathname.split("/"))=="login" 
		

url="/user/#{user}"

# post '/user/:username' do
# user=params["username"]
# password=params["password"]




window.redirect_to_login=redirect_to_login

$(document).ready =>
	$.post(url,{"password":password,"type":"json"}).fail(redirect_to_login).done((r)->check_result(r))
