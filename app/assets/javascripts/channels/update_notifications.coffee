App.update_notifications = App.cable.subscriptions.create "UpdateNotificationsChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data)  ->
    console.log data
    $('#update_bargain').prepend data
   
    
    # Called when there's incoming data on the websocket for this channel

  test: (message) ->
    console.log message   
    @perform 'test', message: message