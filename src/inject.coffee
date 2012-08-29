BLACKLIST = ///

  # Twitter has its own fresh jQuery, and injecting our own breaks it because
  # of some unknown race condition.
  .*twitter.com.*
///

shuffle_pointers = ->
  @injected = window.$
  if @o$
    unless window.$$
      window.$$ = @injected
      @name = '$$'
    else unless window.$_
      window.$_ = @injected
      @name = '$_'
    else unless window.$j
      window.$j = @injected
      @name = '$j'
    else
      window.jQ = @injected
      @name = 'jQ'
    window.$ = @o$
  else
    @name = '$'
  if @oj
    window.jQuery = @oj

tell_extension = (msg)->
  @head.dataset.aij_comm = JSON.stringify msg
  @head.dispatchEvent new CustomEvent 'aij_comm'

tell_name = ->
  @name ?= ''
  tell_extension name: @name

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
  @head.appendChild tag

save_originals = ->
  try
    @o$ = $
  try
    @oj = jQuery

clobber = =>
  window.$ = @injected
  @name = '$'
  tell_name()

listen_for_clobber = ->
  @head.addEventListener 'aij_clobber', clobber

main = ->
  @head = document.head
  set_focus_behavior()
  tell_name()
  unless blacklisted()
    save_originals()
    load_jquery()
    listen_for_clobber()

main()
