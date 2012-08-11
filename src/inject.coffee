cache_originals = ->
  @orig_$ = window.$      if window.$
  @orig_j = window.jQuery if window.jQuery

reset_originals = ->
  #
  # TODO
  #
  # This needs to set the jQuery that we want to keep to some other name then
  # report to the user what that name is.
  #
  window.$      = @orig_$
  window.jQuery = @orig_j

set_version = ->
  @version = $().jquery

set_name = ->
  # TODO

load_jquery = (callback)->
  tag = document.createElement 'script'
  protocol = if location.protocol == 'https:' then 'https:' else 'http:'
  tag.src = "#{protocol}//code.jquery.com/jquery.min.js"
  tag.onload = ->
    callback()
  document.querySelector('head').appendChild tag

main = ->
  cache_originals()
  load_jquery ->
    set_name()
    set_version()
    reset_originals()

main()
