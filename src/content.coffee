script = ->
  tag = document.createElement 'script'
  tag.src = chrome.extension.getURL('lib/inject.js')
  tag

head = ->
  document.head

aij_comm = ->
  JSON.parse head().dataset.aij_comm

report_script_name = (e)->
  chrome.extension.sendMessage
    type: 'script_name'
    name: aij_comm().name

main = ->
  head().addEventListener 'aij_comm', report_script_name
  head().appendChild script()

main()
