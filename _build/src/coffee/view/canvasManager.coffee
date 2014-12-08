$ = require "jquery"
instance = null

class CanvasManager
  constructor: ->
    @canvas = $( "#canvas" ).get 0
    if !@canvas.getContext
      alert "This browser doesn\'t supoort HTML5 Canvas."
      return undefined

    @context = @canvas.getContext "2d"

  resetContext: ( width, height )->
    @canvas.width = width
    @canvas.height = height

  clear: ->
    @context.clearRect 0, 0, @canvas.width, @canvas.height

  drawDot: ( x, y, color )->
    @context.fillStyle = color
    @context.fillRect x, y, 1, 1

  drawImg: ( img )->
    @context.drawImage img, 0, 0

  createImage: ( width, height )->
    @context.createImageData( width, height )

  getImage: ( x, y, width, height )->
    @context.getImageData( x, y, width, height )

  getContext: ->
    @context

getInstance = ->
  if !instance
    instance = new CanvasManager()
  instance

module.exports = getInstance
