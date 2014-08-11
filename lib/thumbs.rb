THUMBS_DIRNAME="thumbs"



module Thumbs
 

  
  def make_thumb file_name
    mkdir thumbs
    mogrify  -format gif -path thumbs -thumbnail 100x100 *.jpg
  end

  
  def make_dirs
    Dir.mkdir "./public" unless Dir.exists? "./public"
    Dir.mkdir IMAGE_CONTAINER unless Dir.exists? IMAGE_CONTAINER
    Dir.mkdir File.join(IMAGE_CONTAINER, THUMBS_DIRNAME) unless Dir.exists? File.join(IMAGE_CONTAINER, THUMBS_DIRNAME)
  end
  
end









if $0 == __FILE__
  puts "I am running solo"
  IMAGE_CONTAINER="./public/image_container"
  Thumbs.make_dirs

end


get '/images/:username/:algname' do
  username=params["username"]
  algname=params['algname']
  basepath=File.join(IMAGE_CONTAINER,username)
  algdir=File.join(basepath,algname)
  query="#{algdir}/**/*"  
  r=Dir.glob query