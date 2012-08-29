badge =
  init: ->
    chrome.browserAction.setBadgeBackgroundColor color: '#5db0e6'
    chrome.browserAction.onClicked.addListener (tab)->
      chrome.tabs.sendMessage tab.id, 'clobber'

  text: (text)->
    chrome.browserAction.setBadgeText text: text

listen_for_script_name = ->
  chrome.extension.onMessage.addListener (request, sender, send_response)->
    badge.text request.name if request.type is 'script_name'

main = ->
  badge.init()
  listen_for_script_name()

main()
