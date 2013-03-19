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

tell_name = ->
  @name ?= ''
  @head.dataset.aij_comm = JSON.stringify name: @name
  @head.dispatchEvent new CustomEvent 'aij_comm'

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

main = ->
  @head = document.head
  window.addEventListener 'focus', tell_name
  tell_name()
  save_originals()
  load_jquery()
  @head.addEventListener 'aij_clobber', clobber

main()
