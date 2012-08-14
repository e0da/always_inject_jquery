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
  @head.dataset.aij_comm = JSON.stringify
    name: @name
  @head.dispatchEvent new CustomEvent 'aij_comm'

set_focus_behavior = ->
  window.addEventListener 'focus', tell_name

load_jquery = ->
  tag = document.createElement 'script'
  protocol = if location.protocol == 'https:' then 'https:' else 'http:'
  tag.src = "#{protocol}//ajax.googleapis.com/ajax/libs/jquery/1/jquery.min.js"
  tag.onload = ->
    shuffle_pointers()
    tell_name()
    set_focus_behavior()
  @head.appendChild tag

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
