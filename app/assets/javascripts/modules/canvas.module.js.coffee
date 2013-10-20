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
  selectTool: (tool, action, reporter) ->
    reporter.text 'selected: ' + tool
    if action is 'draw' then @drawSnapPoints() else @clearCanvas()

  # Check if key is a shortcut and select corresponding tool
  handleKeyDown: (keyCode, reporter) ->
    switch keyCode
      # Draw
      when 82 then @selectTool 'rect', 'draw', reporter
      when 68 then @selectTool 'line', 'draw', reporter
      when 67 then @selectTool 'circle', 'draw', reporter
      # Adjust
      when 88 then @selectTool 'move' , 'adjust', reporter
      when 83 then @selectTool 'scale', 'adjust', reporter
      when 69 then @selectTool 'rotate', 'adjust', reporter
      # Flow
      when 76 then @selectTool 'loop', 'flow', reporter
      # Unselect
      when 27 then @selectTool 'none', 'none', reporter

  drawSnapPoints: ->
    @context.lineWidth = 1
    @context.strokeStyle = '#333333'
    @context.fillStyle = '#ffff4d'
    for point in @snapPoints
      @context.beginPath()
      @context.arc point.x, point.y, point.radius, 0, Math.PI * 2, false
      @context.stroke()
      @context.fill()
      @context.closePath()

