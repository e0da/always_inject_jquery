badge =
  init: ->
    chrome.browserAction.setBadgeBackgroundColor color: '#5db0e6'

  text: (text)->
    chrome.browserAction.setBadgeText text: text

listen = (id, callback)->
  chrome.extension.onMessage.addListener (request, sender, send_response)->
    callback() if request.id == id

set_name_on_badge = (request)->
    badge.text name
    console.log request.name, request.version

main = ->
  badge.init()
  listen 'name and version', set_name_on_badge

main()
