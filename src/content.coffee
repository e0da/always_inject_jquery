read_value = ->
  msg = JSON.parse document.getElementById('yoyoyo').dataset.msg
  console.log msg.msg

setTimeout read_value, 100
