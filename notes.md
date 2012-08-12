- May have to reset badge icon every tab change!
- Option for outputting version and name to console?
- Need surrogate content script to handle communication from inject.js, so
  inject.js and content_surrogate.js can communicate by attaching/listening to
  events on some appended object in the DOM.
  - Wait. Is that right? Figure why sendMessage is undefined in injected
    script. Is it because web_accessible_resources can't also be content
    scripts?
  - Message passing between content script and web accessible scripts can be
    accomplished _possibly_ by using actual JavaScript events on an object OR
    by setting data on the object OR by making the object invisible and then
    setting its innerHTML as `JSON.stringify(messageObject)` and using `eval()`
    to retrieve it.
