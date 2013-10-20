Shape = require 'modules/shape'
SnapPoint = require 'modules/snap_point'

module.exports = class Canvas
  constructor: (@canvas) ->
    @context = @canvas.getContext '2d'
    @width = @canvas.width
    @height = @canvas.height
    # Create 9 snap points
    @snapPoints = [
      #              x           y            name
      new SnapPoint  @width / 2, 0,           'top'
      new SnapPoint  0,          0,           'top-left'
      new SnapPoint  @width,     0,           'top-right'
      new SnapPoint  @width / 2, @height / 2, 'mid'
      new SnapPoint  0,          @height / 2, 'mid-left'
      new SnapPoint  @width,     @height / 2, 'mid-right'
      new SnapPoint  @width / 2, @height,     'bot'
      new SnapPoint  0,          @height,     'bot-left'
      new SnapPoint  @width,     @height,     'bot-right'
    ]

  init: ->
    # Listen for mouse movements on the canvas
    @canvas.addEventListener 'mousemove', (e) =>
      bounds = @canvas.getBoundingClientRect()
      x = e.clientX - bounds.left
      y = e.clientY - bounds.top

  clearCanvas: ->
    @context.clearRect 0, 0, @width, @height

  # Select tool passed in
  selectTool: (tool, action) ->
    if action is 'draw' then @drawSnapPoints() else @clearCanvas()
    'selected: ' + tool

  drawSnapPoints: ->
    @clearCanvas()
    @context.lineWidth = 1
    @context.strokeStyle = '#333333'
    @context.fillStyle = '#ffff4d'
    for point in @snapPoints
      @context.beginPath()
      @context.arc point.x, point.y, point.radius, 0, Math.PI * 2, false
      @context.stroke()
      @context.fill()
      @context.closePath()

