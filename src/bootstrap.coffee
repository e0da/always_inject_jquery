script = ->
  tag = document.createElement 'script'
  protocol = if location.protocol == 'https:' then 'https:' else 'http:'
  tag.src = chrome.extension.getURL 'lib/inject.js'
  tag

head = ->
  document.querySelector 'head'

main = ->
  head().appendChild script()
  chrome.browserAction.setBadgeText {text: 'yo'}

main()
