App.update_notifications = App.cable.subscriptions.create { channel: "UpdateNotificationsChannel", id: location.href.split('/')[4] },
  
  connected: ->
    if location.href.search('current_bargain') == -1
      console.log 'dis' 
    else
      console.log location.href.search('current_bargain')


  disconnected: ->

  received: (data)  ->
    console.log data
    alert = $('#update_bargain')
    alert.show()
    nowTime = new Date
    alert.text(data + ' ' + nowTime.toGMTString())

  test: (message) ->
    console.log message   
    @perform 'test', message: message
  
  