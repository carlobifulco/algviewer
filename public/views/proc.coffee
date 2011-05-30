# Our main sketch object:
coffee_draw = (pc) ->  

  # processing's "init" method:
  pc.setup = () ->
    pc.size($(window).width(), $(window).height())
    pc.background(255)
    pc.strokeWeight(10)
    pc.frameRate(15)
    pc.ellipse(50, 50, 25, 25)
    pc.ellipse(50, 200, 100, 100)
    pc.ellipse(50, 400, 300, 100)
    pc.println("SSDSDSDSD")
    pc.X = width / 2
    pc.Y = height / 2
    pc.nX = X
    pc.nY = Y
    pc.delay=16
    
  # where the fun stuff happens:
  pc.draw = () ->
    # to make sure everything's working
    # let's do a quick test:

    # set the value of the background equal
    # to the sketch's current frame count
    # and the whole canvas will pulse different colors



    radius = radius + sin( pc.frameCount / 4 );

      // Track circle to new destination
    pc.X+=(pc.nX-pc.X)/delay
    pc.Y+=(pc.nY-pc.Y)/delay

      // Fill canvas grey
    pc.background( 100 )

      // Set fill-color to blue
    pc.fill( 0, 121, 184 )

      // Set stroke-color white
    pc.stroke(255)

      // Draw circle
    pc.ellipse( X, Y, radius, radius )


    // Set circle's next destination
    void mouseMoved(){
      nX = mouseX;
      nY = mouseY;  
    }





# wait for the DOM to be ready, 
# create a processing instance...
$(document).ready ->
  canvas = $("#canvas")[0]
  processing = new Processing(canvas, coffee_draw)
  window.p=Processing.getInstanceById('canvas')
