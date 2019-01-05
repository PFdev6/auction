App.notification = App.cable.subscriptions.create "NotificationChannel",
  connected: ->

  disconnected: ->

  received: (data)  ->
    console.log data
    $('#messages').prepend data
    console.log  $('#messages').children().length
    $('#count_notification').text $('#messages').children().length
    
    # Called when there's incoming data on the websocket for this channel

  notify: (message, user) ->
    console.log message, user    
    @perform 'notify', message: message, user: user