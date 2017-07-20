App.notifications = App.cable.subscriptions.create "NotificationsChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    # Called when there's incoming data on the websocket for this channel
    $('#js-notifications-label').html(parseInt($('#js-notifications-label').text()) + 1)
    headerText = $('#js-notifications-header').html()
    $('#js-notifications-header').html(headerText.replace(/\d+/, (parseInt(headerText.match(/\d+/)[0]) + 1)))
    $("#js-notifications").prepend(data.html)
