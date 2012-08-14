load_script = (url, callback=null)->
  tag = document.createElement 'script'
  tag.src = url
  tag.onload = callback if callback
  @head.appendChild tag

load_inject = ->
  load_script chrome.extension.getURL('lib/inject.js'), ->
    load_jquery()

load_jquery = ->
  protocol = if location.protocol == 'https:' then 'https:' else 'http:'
  load_script "#{protocol}//code.jquery.com/jquery.min.js", ->
    # console.log $, jQuery

head = ->
  document.querySelector 'head'

inject = ->
  @head.appendChild script()

tell_extension = (msg)->
  chrome.extension.sendMessage msg

tell_extension_name = (e)=>
    msg = JSON.parse @head.dataset.aij_comm
    chrome.extension.sendMessage
      type: 'name and version'
      name: @name

set_up_comm = ->
  @head.addEventListener 'aij_comm', tell_extension_name

main = ->
  @head = head()
  set_up_comm()
  load_inject()

main()
