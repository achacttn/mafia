// App.messages = App.cable.subscriptions.create('MessagesChannel', {

$(document).ready(function () {

  if( $('body.rooms.show').length ){

    // Create a new websockets channel just for this room ID
    // (this calls the 'subscribed' method in app/channels/messages_channel.rb)
    App.room_messages = App.cable.subscriptions.create({channel: 'MessagesChannel', room_id: room_id }, {
      received: function(data) {

        console.log('received:', data);

        switch(data.action){
          case 'message':
            console.log('messages', data);
            const msg = "<p> <b>" + data.user + ": </b>" + data.message + "</p>";
            $('#messages')
            .append( msg )
            .scrollTop( $('#messages')[0].scrollHeight );
            // return ret;
            break;
          case 'READY_TO_START':

            $('#start').show();
            // another switch here to handle different data.type
            break;
          // case 'UPDATING_PLAYERS':
          //   console.log('working?', data);
          //   const list_of_p = [];
          //   data.users.forEach( u => {
          //     list_of_p.push("<p><b>" + u.name +"</b></p>")
          //   } )
          //   $('#playerlist').append( list_of_p )
          //   break;
          case 'GAME_HAS_STARTED':
            // $('#').show()
            console.log(data);
            startGame(data);
            // 1. assign roles to each player (loop over data.roles and set variable for each player that says whether they're mafia or citizen)
            //     - if they're mafia, also show an icon next to the other mafia players in the list for their room), and activate the mafia websockets channel for them
            // 2. start the timer for all players

            break;

          case 'PERSON_JOINED':
            // check for canStart player number here
            //$('#start').show(); show the start button
            if( data.id === user_id ){
              return;
            }

            users[data.id] = data.name

            if( Object.keys(users).length === 3){
              // show game button
              $('#start').show();
              $('#notEnoughPlayers').hide();
            }

            //add new player to the existing list
              let aaa = `<div id="user${ data.id }"><b>${ data.name }</b>&nbsp; &nbsp;<input type="radio" name="vote" value="${data.id} id ="radio${data.id}"></div>`;

            $('#playerlist').append( aaa );
          break;

          case 'PERSON_LEFT':
          // check for canStart player number here
          //$('#start').show(); show the start button
            console.log('PERSON_LEFT', data);
            delete users[data.id];
            $(`#user${ data.id }`).remove();

            if( Object.keys(users).length < 3){
              // show game button
              $('#start').hide();
            }

          break;

          case "NEXT_ROUND":
            console.log("NEXT_ROUND", data);
            console.log("NEXT_ROUND: Death", data.death);
            $(`#user${parseInt(data.death)}`).css("text-decoration", "line-through");
            $(`#radio${parseInt(data.death)}`).hide();
            // let annoucement = "";
            // if (true) {
            //
            // } else if {
            //
            // }
            $("#timesup").html(`Player ${data.user.name} is dead! Mafia: ${data.user.stateobject["mafia"]}`);
          break;
        }
      },

      send_message: function( data ){
        console.log( 'send_message', data  );
        this.perform('send_message', data );
      },

      // assign_roles: function( data ){
      //   this.perform();
      // }


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
      },

      send_message: function( data ){
        console.log( 'send_message', data );
        this.perform('send_message', data );
      }

    });



    //Create a new websockets channel just for votes
    App.vote = App.cable.subscriptions.create({channel: "VoteChannel", room_id: room_id },
    {
      received: function(data) {
        console.log("vote message", data);

        let count = parseInt($("#voteDisplay").text());

        if (data["action"]=="add"){
          $("voteDisplay").html(count +1)
        } else if (data["action"]=="subtract"){
          $("voteDisplay").html(count +1)
        }

        let totalCount = 0;

      },

      voted: function(data){
        console.log("send_vote_message", data);
        this.perform('send_voted_message', data)
      },

      // reduce: function(data){
      //   console.log("send_reduce_message", data);
      //   this.perform('send_reduce_message', data)
      // }
    })

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
