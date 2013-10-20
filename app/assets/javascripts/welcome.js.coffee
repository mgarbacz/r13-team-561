Canvas = require 'modules/canvas'

$ ->
  # Make sure canvas has proper height/width
  canvasElement = $('#guided-canvas')
  canvasElement[0].width = canvasElement.width()
  canvasElement[0].height = canvasElement.width() / 2

  # Load up the DYD magic
  canvas = new Canvas canvasElement[0]
  canvas.init()

  # Listen for keyboard events to check if shortcut
  $(document).keydown (e) ->
    $('#guided-step').text canvas.handleKeyDown e.keyCode

  # Listen for click events on tool list
  $('#shortcuts dl > dt').click (e) ->
    tool = $(this).data('tool')
    action = $(this).data('action')
    $('#guided-step').text canvas.selectTool tool, action
