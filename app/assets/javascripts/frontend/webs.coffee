# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

copyToClipboard = (text) ->
  if window.clipboardData and window.clipboardData.setData
    # IE specific code path to prevent textarea being shown while dialog is visible.
    return clipboardData.setData('Text', text)
  else if document.queryCommandSupported and document.queryCommandSupported('copy')
    textarea = document.createElement('textarea')
    textarea.textContent = text
    textarea.style.position = 'fixed'
    # Prevent scrolling to bottom of page in MS Edge.
    document.body.appendChild textarea
    textarea.select()
    try
      return document.execCommand('copy')
      # Security exception may be thrown by some browsers.
    catch ex
      console.warn 'Copy to clipboard failed.', ex
      return false
    finally
      document.body.removeChild textarea
  return

ready = ->
  document.querySelector('#copy').onclick = (e) ->
    e.preventDefault()
    result = copyToClipboard $(this).attr('href')
    if result
      alert('複製成功')
    else
      alert('複製失敗')
    return

$(document).ready(ready)
$(document).on('page:load', ready)
