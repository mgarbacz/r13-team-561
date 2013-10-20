Canvas = require 'modules/canvas'

$ ->
  # Make sure canvas has proper height/width
  canvasElement = $('#guided-canvas')
  canvasElement[0].width = canvasElement.width()
  canvasElement[0].height = canvasElement.height()

  # Load up the DYD magic
  canvas = new Canvas canvasElement[0]
  canvas.init()

  # Listen for keyboard events to check if shortcut
  $(document).keydown (e) ->
    canvas.handleKeyDown e.keyCode, $('#guided-step')

  # Listen for click events on tool list
  $('#shortcuts dl > dt').click (e) ->
    canvas.selectTool $(this).text(),
                      $(this).closest('.text-info').text(),
                      $('#guided-step')

