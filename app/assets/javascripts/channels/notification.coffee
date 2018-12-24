App.notification = App.cable.subscriptions.create "NotificationChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    $('#messages').prepend data
    n = $('#messages').children().length
    $('#count_notification').text n
    return 
    # Called when there's incoming data on the websocket for this channel
  notify: (message) ->
    @perform 'notify', message: message