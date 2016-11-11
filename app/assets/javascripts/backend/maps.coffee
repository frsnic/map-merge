# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

ready = ->
  $('.btn.more').click ->
     $('.dot-list li').show()
     $('.btn.more').hide()

$(document).ready(ready)
$(document).on('page:load', ready)
