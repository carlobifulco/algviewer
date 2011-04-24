$(document).ready ->

  #info on alg in in url galleria/algname/nodeid
  #images are pulled and displayes...
  show_images=(algname,nodeid)=>
    if nodeid
      url="/images/#{localStorage.user}/#{algname}/#{nodeid}"
    else
      url="/images/#{localStorage.user}/#{algname}"
    console.log url
    console.log nodeid
    #display async
    $.get(url,(e)->display(e))
  

  # activates the gallery
  display=(e)=>
    filenames={filenames:JSON.parse(e)}
    template='
         {{#filenames}}
         <img src={{.}} alt="My description" title="My title"></img>
         {{/filenames}}'
    console.log e
    console.log filenames
    console.log template
    menu=Mustache.to_html(template,filenames)   
    console.log menu
    Galleria.loadTheme('/galleria/themes/classic/galleria.classic.min.js') 
    $("#galleria").append(menu)
    $("#galleria").galleria(height:500,preload: 6)
    
  #"/galleria/algname/nodeid".split("/")
  # info for wich node to display is encoded in the url
  # can find all images for alg or all images for a node
  url=window.location.pathname.split("/")
  if url[3]
    nodeid=_.last(url)
    algname=url[2] 
  else
    nodeid=false
    algname=url[2]
  show_images(algname,nodeid)

