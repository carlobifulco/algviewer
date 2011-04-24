
# wait for the DOM to be ready, 
# create a processing instance...
$(document).ready ->
  window.a=[]
  
  #Shipping
  #---------
  #takes files and destination and POST them one by one to
  #/upload/user/alg/nodeid
  class Ship
    
    constructor:(files,nodeid,url)->
      @files=files
      @nodeid=nodeid
      @url=url
      console.log(files)
      window.files=files
      count = files.length
      console.log(files)
      console.log(count)
      #
      @uploader_url="/upload/#{localStorage.user}/#{_.last(window.location.pathname.split("/"))}/#{nodeid}"
    
      
    ship:()=>
      @ship_file(i) for i in @files
    
    # update load status  
    loadProgress:(reader)=>
      console.log "STATUS CALLED"
      console.log reader
      if reader.lengthComputable
        percentage=Math.round((reader.loaded * 100) / reader.total)
        $("#loadStatus")[0].innerHTML="loaded: #{percentage}%"
 
    
    loadShip:(reader,file)=>
      console.log("loaded")
      #console.log(reader.result)
      #our file reader...
      bin=reader.result
      #console.log(bin)
      #bin=@reader.result
      #window.bin=bin
      xhr = new XMLHttpRequest()
      xhr.open('POST', @uploader_url+'?up=true', true)
      boundary = 'xxxxxxxxx'
      body = '--' + boundary + "\r\n"
      body += "Content-Disposition: form-data; name='upload'; filename='" + file.name + "'\r\n"
      body += "Content-Type: application/octet-stream\r\n\r\n"
      body += bin + "\r\n"
      body += '--' + boundary + '--'
      xhr.setRequestHeader('content-type', 'multipart/form-data; boundary=' + boundary)
      #webkit
      if xhr.sendAsBinary
         xhr.sendAsBinary(body)
      #chrome
      else
        xhr.open('POST', @uploader_url+'?up=true&base64=true', true)
        xhr.setRequestHeader('UP-FILENAME', file.name)
        xhr.setRequestHeader('UP-SIZE', file.size)
        xhr.setRequestHeader('UP-TYPE', file.type)
        #console.log(@reader.result)
        bin=window.btoa(bin)
        xhr.send(bin)
        xhr.addEventListener("progress",@loadProgress,false)
        xhr.onreadystatechange=(e)=>
          console.log(e)
          if e.target.readyState==4
            if e.target.status==200
              $("progress.#{@nodeid}").remove()
              $()
            else
              $("progress.#{@nodeid}").remove()
              alert "error"
        console.log "shipped"
        
        
    #shipping is done in an asynchronous way
    #onloaded called when file is read; then request is formed and shipped  
    ship_file:(file)=>
      @file=file
      reader=new FileReader()
      reader.onloadend = ()=> @loadShip(reader,file)
      reader.onprogress = ()=>@loadProgress(reader)
      
      reader.readAsBinaryString(file)
     
  #Drop binding
  #------------
  
  #on drop
  drop=(evt)=>
    evt.stopPropagation()
    evt.preventDefault()
    console.log(evt)
    console.log evt.srcElement.id
    #add progress bar to node
    $(evt.srcElement).append("<progress class=#{evt.srcElement.id}></progress>")
    console.log(evt.dataTransfer)
    files=evt.dataTransfer.files
    ship=new Ship(files,evt.srcElement.id,"/url")
    ship.ship()
    window.ship=ship
    console.log(ship)
    return false
  
  #other drag events    
  dragEnter=(evt)->
    evt.stopPropagation()
    evt.preventDefault()
    console.log("event...")
    return false
  dragExit=dragEnter
  dragOver=dragEnter
  


  class Gallery
    constructor:(algname,nodeid)->
      @algname=algname
      @nodeid=nodeid
      
    display_images:(e)=>
      $("#"+@nodeid).append("<div id='galleria'></div>")
      filenames={filenames:JSON.parse(e)}
      template='
           {{#filenames}}
           <img src={{.}} alt="My description" title="My title"></img>
           {{/filenames}}'
      menu=Mustache.to_html(template,filenames)   
      console.log menu
      Galleria.loadTheme('/galleria/themes/classic/galleria.classic.min.js') 
      $("#galleria").append(menu)
      console.log   $("#galleria")
      console.log "menu appended"
      $("#galleria").galleria({Height:500, Width:500, preload: 6})
      
    show:()=>
      if @nodeid
        @url="/images/#{localStorage.user}/#{@algname}/#{@nodeid}"
      else
        @url="/images/#{localStorage.user}/#{@algname}"
      console.log "In Gallery class and pulling nodes images from #{@url}"
      #display async
      $.get(@url,(e)=>@display_images(e))
         



  new_gallery=(algname,nodeid)=>
    new Gallery algname, nodeid
  window.new_gallery=new_gallery
    



  # activates the gallery



    #Testing utility
    #-----------------

  add_node=(nodeid)=>
    a=[]
    algname=_.last(window.location.pathname.split("/")) 
    if algname=="" then algname="test"  
    window.algname=algname
    nodeid=Math.floor(Math.random()*100)
    $("#drop_point").append("<div id=node#{nodeid} class=text_box node=#{nodeid}> <p id=node#{nodeid}>DRAG HERE #{nodeid}</p> </div><br>")
    $("#node#{nodeid}").dblclick(()->window.location.href="/galleria/#{algname}/node#{nodeid}")
  #    href: "http://localhost:4567/galleria/test/node1
    dropbox = $("#node#{nodeid}")
    dropbox.bind("dragenter", dragEnter)
    dropbox.bind("dragexit", dragExit)
    dropbox.bind("dragover", dragOver)
    dropbox.get(0).addEventListener('drop', drop, false)

    # '/upload/:username/:algname/:nodeid'
    # uploader_url="/upload/#{localStorage.user}/#{algname}/#{nodeid}"
    # uploader("node#{nodeid}", 'status', uploader_url, 'show')
    # console.log uploader_url


      # window.up=up


    #add_node(i) for i in [1..10]

  add_drop=()=>
    #algname=
    dropboxes = $(".text_box")
    dropboxes.bind("dragenter", dragEnter)
    dropboxes.bind("dragexit", dragExit)
    dropboxes.bind("dragover", dragOver)
    i.addEventListener('drop', drop, false) for i in dropboxes
    console.log(i.id) for i in dropboxes 
    $(i).dblclick((evt)=>new_gallery(_.last(window.location.pathname.split("/")),evt.srcElement.id).show()) for i in dropboxes
     #$(i).dblclick((evt)=>window.location.href="/galleria/#{_.last(window.location.pathname.split("/"))}/#{evt.srcElement.id}") for i in dropboxes

  window.add_drop=add_drop
  add_drop()



  

  