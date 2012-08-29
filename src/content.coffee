script = ->
  tag = document.createElement 'script'
  tag.src = chrome.extension.getURL('lib/inject.js')
  tag

aij_comm = ->
  JSON.parse @head.dataset.aij_comm

report_script_name = (e)->
  chrome.extension.sendMessage
    type: 'script_name'
    name: aij_comm().name

clobber = ->
  @head.dispatchEvent new CustomEvent 'aij_clobber'

listen_for_clobber = ->
  chrome.extension.onMessage.addListener (message)->
    clobber() if message is 'clobber'

main = ->
  @head = document.head
  @head.addEventListener 'aij_comm', report_script_name
  @head.appendChild script()
  listen_for_clobber()

main()
