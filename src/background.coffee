badge =
  init: ->
    chrome.browserAction.setBadgeBackgroundColor color: '#5db0e6'
    chrome.browserAction.onClicked.addListener (tab)->
      chrome.tabs.sendMessage tab.id, 'clobber'

  text: (text)->
    chrome.browserAction.setBadgeText text: text

listen = (type, callback)->
  chrome.extension.onMessage.addListener (request, sender, send_response)->
    callback(request) if request.type == type

set_name_on_badge = (request)->
  badge.text request.name

main = ->
  badge.init()
  listen 'script_name', set_name_on_badge

main()
