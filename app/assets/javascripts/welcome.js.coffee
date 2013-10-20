# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

# Select tool passed in
selectTool = (tool) ->
  $('#guided-step').text 'selected: ' + tool

# Check if key is a shortcut and select corresponding tool
handleKeyDown = (keyCode) ->
  switch keyCode
    # Draw
    when 82 then selectTool 'rect'
    when 68 then selectTool 'line'
    when 67 then selectTool 'circle'
    # Adjust
    when 88 then selectTool 'move'
    when 83 then selectTool 'scale'
    when 69 then selectTool 'rotate'
    # Flow
    when 76 then selectTool 'loop'
    # Unselect
    when 27 then selectTool 'none'

$ ->
  # Listen for keyboard events to check if shortcut
  $(document).keydown (e) ->
    handleKeyDown e.keyCode

  # Listen for click events on tool list
  $('#shortcuts dl > dt').click (e) ->
    selectTool $(this).text()
