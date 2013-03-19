blank_name = ->
  chrome.extension.sendMessage
    type: 'script_name'
    name: ''

window.addEventListener 'focus', blank_name
