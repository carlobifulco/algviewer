
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
  

  #Display nodes images
  #---------------------
  #images are created from html that is then dysplayed via facebox
  #thumbs in facebox are then doubleclicked to images 
  #via $(document).bind('reveal.facebox',()->$(".thumbs").dblclick((e)->show_image e)) hook
  class Gallery
    constructor:(algname,nodeid, text)->
      @algname=algname
      @nodeid=nodeid
      @text=text.split("\n")[0]
      #username is available as localStorage if in graphic edit mode
      if  window.location.pathname.split("/")[1]=="graphic_edit"
        @username=localStorage.user
      #username available in URL when looking at a dinamic SVG
      else
        @username=window.location.pathname.split("/")[2] 
       
    
    #e is deferred form show
    display_images:(e)=>
      
      filenames=JSON.parse(e)
      console.log "HELLP #{filenames.length}"
      #alert (filenames.length)
      if (filenames.length != 0 and filenames !="" and filenames != undefined)
        console.log "templating without a template; #{@text}"
        filenames={filenames:filenames,text:@text}
        console.log filenames
        template='
             {{#filenames}}
             <img src={{.}} alt="My description" class="thumbs" title="My title" class=facebox><div id=image></img>
             {{/filenames}}
             <h4 id="popup">{{text}}</h4>'
        menu=Mustache.to_html(template,filenames)   
        console.log "thumbs #{menu}"
        $(menu).click((e)=>console.log(e))
        console.log menu
        console.log "DISPLAY CALLED"
        console.log filenames["filenames"]
        $.facebox(menu)
        window.images=false
        window.last_menu=menu
      
    show:()=>
      if @nodeid
        @url="/thumbs/#{@username}/#{@algname}/#{@nodeid}"
      else
        @url="/thumbs/#{@username}/#{@algname}"
      console.log "In Gallery class and pulling nodes images from #{@url}"
      #display async
      $.get(@url,(e)=>@display_images(e))
         


  #utility function
  new_gallery=(algname,nodeid,text)=>
    new Gallery algname, nodeid,text
  window.new_gallery=new_gallery
    
  # e is the thumb; replaces .gif with jpg --for the matching image-- and then displays
  show_image=(e)->
    console.log e
    console.log e.srcElement
    url=$(e.srcElement).attr("src")
    url=url.replace(".gif",".jpg")
    console.log url
    $.facebox({ image: url })
    window.images=true
  
  # last menu is the last popup
  #  only if displaying a single image the menu is recreated
  close_facebox=()->
    console.log window.last_menu
    console.log window.images
    if images
      $.facebox(window.last_menu)
      window.images=false
  


  # activates the gallery



    #Testing utility
    #-----------------

  # add_node=(nodeid)=>
  #   a=[]
  #   algname=_.last(window.location.pathname.split("/")) 
  #   if algname=="" then algname="test"  
  #   window.algname=algname
  #   nodeid=Math.floor(Math.random()*100)
  #   $("#drop_point").append("<div id=node#{nodeid} class=text_box node=#{nodeid}> <p id=node#{nodeid}>DRAG HERE #{nodeid}</p> </div><br>")
  #   $("#node#{nodeid}").dblclick(()->window.location.href="/galleria/#{algname}/node#{nodeid}")
  # #    href: "http://localhost:4567/galleria/test/node1
  #   dropbox = $("#node#{nodeid}")
  #   dropbox.bind("dragenter", dragEnter)
  #   dropbox.bind("dragexit", dragExit)
  #   dropbox.bind("dragover", dragOver)
  #   dropbox.get(0).addEventListener('drop', drop, false)


  
  #binding of drop and dblclick events on ALL .text_box elements 
  #---------------------------------------------------------
  add_drop=()=>
    #algname=
    dropboxes = $(".text_box")
    #needed otherwise multiple updates would bind multiple dbclicks...
    dropboxes.unbind("dblclick")
    dropboxes.bind("dragenter", dragEnter)
    dropboxes.bind("dragexit", dragExit)
    dropboxes.bind("dragover", dragOver)
    i.addEventListener('drop', drop, false) for i in dropboxes
    console.log(i.id) for i in dropboxes 
    #binds new_gallery(algname, nodeid).show() to doubleclick
    $(i).dblclick((evt)=>new_gallery(_.last(window.location.pathname.split("/")),evt.srcElement.id).show()) for i in dropboxes
    console.log "ADD DROP CALLED"
     #$(i).dblclick((evt)=>window.location.href="/galleria/#{_.last(window.location.pathname.split("/"))}/#{evt.srcElement.id}") for i in dropboxes
  

    
  
  window.add_drop=add_drop
  
  ##Show images on clicking of thumbs
  $(document).bind('reveal.facebox',()->$(".thumbs").dblclick((e)->show_image e))
  window.images=false
  $(document).bind('afterClose.facebox',()->close_facebox())


  

  