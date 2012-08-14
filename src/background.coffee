badge =
  init: ->
    chrome.browserAction.setBadgeBackgroundColor color: '#5db0e6'

  text: (text)->
    chrome.browserAction.setBadgeText text: text

listen = (type, callback)->
  chrome.extension.onMessage.addListener (request, sender, send_response)->
    callback(request) if request.type == type

set_name_on_badge = (request)->
  console.log request
  badge.text request.name

main = ->
  badge.init()
  listen 'name and version', set_name_on_badge

main()
