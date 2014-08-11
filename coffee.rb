#### Documentation self production and taking care of coffeescript JS conversion
### By spawning all process push into the ./doc directory

Process.spawn '~/Dropbox/code/utilities/doc_maker.rb .' 
Process.spawn '~/Dropbox/code/utilities/doc_maker.rb ./public/views' if  Dir.exists?  './public/views'
Process.spawn '~/Dropbox/code/utilities/doc_maker.rb ./lib'  if  Dir.exists? './lib'
