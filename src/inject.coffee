BLACKLIST = ///

  # Twitter has its own fresh jQuery, and injecting our own breaks it because
  # of some unknown race condition.
  .*twitter.com.*
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

tell_extension = (msg)->
  @head.dataset.aij_comm = JSON.stringify msg
  @head.dispatchEvent new CustomEvent 'aij_comm'

tell_name = ->
  @name ?= ''
  tell_extension name: @name

blank_name = ->
  tell_extension name: ''

set_focus_behavior = ->
  window.addEventListener 'focus', tell_name
  window.addEventListener 'blur', blank_name

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

main = ->
  @head = document.head
  set_focus_behavior()
  tell_name()
  unless blacklisted()
    save_originals()
    load_jquery()

main()
