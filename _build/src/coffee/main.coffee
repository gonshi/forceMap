###!
  * Main Function
###

$ = require "jquery"
CanvasManager = require "./view/canvasManager"
DotManager = require "./view/dotManager"
Ticker = require "./util/ticker"

random = Math.random
round = Math.round

$ ->
  canvasManager = CanvasManager()
  ticker = Ticker()
  DOT_PACE = 50 # NUM OF DOTS PER UPDATE
  ACC = 0.05
  dots = []
  canvas_width = $( "#canvas" ).width()
  canvas_height = $( "#canvas" ).height()

  logo_img = new Image()
  logo_img.src = "img/kayac.png"
  $logo = $( "<canvas>" )
  $logo.get( 0 ).width = canvas_width
  $logo.get( 0 ).height = canvas_height
  logo_context = $logo.get( 0 ).getContext "2d"
  logo_pixel = []

  ###
    LISTENER
  ###
  listen = ->
    ticker.listen ->
      _update()
      _draw()

  ###
    PRIVATE
  ###
  _update = ->
    _createDots()

  _draw = ->
    canvasManager.clear()
    fall_dots = [] # TO DELETE

    length = dots.length
    for i in [ 0...length ]
      _dot = dots[ i ]
      _dot.y += _dot.vel

      if _dot.y > canvas_height
        fall_dots.push i
      # SLOW DOWN IN THE LOGO AREA
      else
        if logo_pixel[ parseInt( _dot.y ) * canvas_width * 4 +
           _dot.x * 4 ] == 0
          _dot.vel = 0.25
          canvasManager.drawDot _dot.x, _dot.y, "rgb(255, 255, 255)"
        else
          _dot.vel += ACC
          canvasManager.drawDot _dot.x, _dot.y, "rgb(255, 255, 255)"

    length = fall_dots.length
    for i in [ 0...length ]
      dots.splice fall_dots[ i ] - i, 1

  _createDots = ->
    for i in [ 0...DOT_PACE ]
      dots.push new DotManager(
        parseInt( random() * canvas_width ), 0 )

  ###
    INIT
  ###
  canvasManager.resetContext canvas_width,
                             canvas_height
  # LOAD LOGO DATA
  logo_img.onload = ->
    logo_context.drawImage logo_img, 0, 0
    logo_data = logo_context.getImageData 0, 0,
                                          canvas_width,
                                          canvas_height
    logo_pixel = logo_data.data
    listen()
