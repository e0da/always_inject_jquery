save_originals = ->
  @original_$      = $
  @original_jQuery = jQuery

original_$ = ->
  window.$j = @original_$
  '$j'

original_jQuery = ->
  window.$jQ = @original_jQuery
  '$jQ'

tell_content_name = ->
  @head.dataset.aij_comm = JSON.stringify
    original_$:      original_$()
    original_jQuery: original_jQuery()
  @head.dispatchEvent(new CustomEvent 'aij_comm')

main = ->
  @head = document.head
  save_originals()
  tell_content_name()

main()
