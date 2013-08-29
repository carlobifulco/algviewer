sys=require "sys"
Reston=require "Reston"
c=console


# HOST TO HIT
#--------------
#HOST="localhost:4567"
#HOST="algviewer.dev"
HOST="carlobifulco.com"
#number of hits
MAX_HITS=100
n=0


test_site=()->
  n+=1
  o=
    parser:rest.parsers.json
  #gets alg yaml
  rest.get("http://#{HOST}/yaml/test?user_name=tester",o).on 'complete',(r)->
    #Reston works better
    reston=Reston.get "http://#{HOST}/graph"
    #posts yaml alg and obtains alg
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

    
