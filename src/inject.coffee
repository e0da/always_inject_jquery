BLACKLIST = ///

  # Twitter has its own fresh jQuery, and injecting our own breaks it because
  # of some unknown race condition.
  .*twitter.com.*

  # Don't know why it doesn't work on Chrome webstore, but it doesn't.
  | .*chrome.google.com/webstore.*
///

shuffle_pointers = ->
  if @o$
    unless window.$$
      window.$$ = $
      @name = '$$'
    else unless window.$_
      window.$_ = $
      @name = '$_'
    else unless window.$j
      window.$j = $
      @name = '$j'
    else
      window.jQ = $
      @name = 'jQ'
    window.$ = @o$
  else
    @name = '$'
  if @oj
    window.jQuery = @oj

tell_name = ->
  @name = '' if blacklisted()
  @head.dataset.aij_comm = JSON.stringify
    name: @name
  @head.dispatchEvent new CustomEvent 'aij_comm'

set_focus_behavior = ->
  window.addEventListener 'focus', tell_name

blacklisted = ->
  @blacklisted ?= location.href.match BLACKLIST

load_jquery = ->
  tag = document.createElement 'script'
  protocol = if location.protocol == 'https:' then 'https:' else 'http:'
  tag.src = "#{protocol}//ajax.googleapis.com/ajax/libs/jquery/1/jquery.min.js"
  tag.onload = ->
    shuffle_pointers()
    tell_name()
  @head.appendChild tag unless blacklisted()
  set_focus_behavior()

save_originals = ->
  try
    @o$ = $
  try
    @oj = jQuery

main = ->
  @head = document.head
  save_originals()
  load_jquery()

main()
