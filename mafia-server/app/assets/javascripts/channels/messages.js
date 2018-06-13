// App.messages = App.cable.subscriptions.create('MessagesChannel', {

$(document).ready(function () {
  if( $('body.rooms.show').length ){

    // Create a new websockets channel just for this room ID
    // (this calls the 'subscribed' method in app/channels/messages_channel.rb)
    App.room_messages = App.cable.subscriptions.create({channel: 'MessagesChannel', room_id: room_id }, {
      received: function(data) {
        console.log('messages', data);
        let msg = "<p> <b>" + data.user + ": </b>" + data.message + "</p>";
        $('#messages')
        .append( msg )
        .scrollTop( $('#messages')[0].scrollHeight );
        // return ret;
      }
    });


    // Create a new websockets channel just for private messages to mafia members
    // (this calls the 'subscribed' method in app/channels/mafia_messages_channel.rb)
    App.mafia_messages = App.cable.subscriptions.create({channel: 'MafiaMessagesChannel', room_id: room_id }, {
      received: function(data) {
        console.log('mafia message', data);
        let msg = "<p> <b>" + data.user + ": </b>" + data.message + "</p>";
        $('#mafiaChannel')
        .append( msg )
        .scrollTop( $('#mafiaChannel')[0].scrollHeight );
        // return ret;
      }
    });

    // Create a new websockets channel just for private messages to this user
    // (this calls the 'subscribed' method in app/channels/private_messages_channel.rb)
    // App.private_messages = App.cable.subscriptions.create({channel: 'PrivateMessagesChannel' }, {
    //   received: function(data) {
    //     console.log('private message', data);
    // const msg = "<p> <b>" + data.user + ": </b>" + data.message + "</p>";
    // $('#messages')
    // .append( msg )
    // .scrollTop( $('#messages')[0].scrollHeight );
    // return ret;
    //   }
    // });

  } // CSS rooms#show test

});
