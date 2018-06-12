App.messages = App.cable.subscriptions.create('MessagesChannel', {
  received: function(data) {
    console.log('message', data);
    const msg = "<p> <b>" + data.user + ": </b>" + data.message + "</p>";
    return $('#messages').append( msg );
  }
});
