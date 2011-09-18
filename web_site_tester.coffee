sys=require "sys"
rest=require "restler"
Reston=require "Reston"
c=console


# HOST TO HIT
#--------------
#HOST="localhost:4567"
#HOST="algviewer.dev"
HOST="carlobifulco.com"

MAX_HITS=100
n=0




test_site=()->

  n+=1
  o=
    parser:rest.parsers.json
  
  rest.get("http://#{HOST}/yaml/test?user_name=tester",o).on 'complete',(r)->
    #Reston works better
    reston=Reston.get "http://#{HOST}/graph"
    data=
      yaml_text:JSON.stringify(r),
      algname:"test",
      user_name:"tester"
      #profile:"true"
    reston.send data
    #response is in data. I guess it is json
    reston.on "data",(r)->
      c.log r.toString()
    reston.on "error",(r)->
      c.log "BOOOD"
  c.log n
  
      
# 100 concurrent requests
test_site() for i in [1..MAX_HITS]

    
#     
# q=Reston.get ("http://#{HOST}/yaml/test?user_name=tester")
# #c.log q
# q.on "success",(r)->
#   c.log r.toString()
# q.on "error",(r)->
#   c.log "FAILUREEEEE"
# q.send({})
#       
  
# # 
#   o=
#     query:

#   rest.get("http://#{HOST}/graph?algname=test&user_name=tester&yaml_text=#{r}",o).on 'complete', (r)->
#      puts r
#    






# require "nestful"
# 
# $HOST="algviewer.dev"
# 
# 100.times do
#   yaml=Nestful.get  "http://#{$HOST}/yaml/test?user_name=tester"
# 
#   o={:yaml_text=>yaml,
#     :type=>"json",
#     :algname=>"test",
#     :user_name=>"tester"}
# 
#   q=Nestful.post "http://#{$HOST}/graph", :params=>o
# 
#   puts q
# end
# 

