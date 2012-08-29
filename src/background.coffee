chrome.browserAction.setBadgeBackgroundColor color: '#5db0e6'

chrome.browserAction.onClicked.addListener (tab)->
  chrome.tabs.sendMessage tab.id, 'clobber'

chrome.extension.onMessage.addListener (request, sender, send_response)->
  if request.type is 'script_name'
    chrome.browserAction.setBadgeText text: request.name
