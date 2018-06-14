
let state = {};

$(document).ready(function () {
  // only use this code in the rooms show page
  if( $('body.rooms.show').length ){

    $('#messages').scrollTop( $('#messages')[0].scrollHeight );
    $("#mafiaChannel").scrollTop($("#mafiaChannel")[0].scrollHeight);

    for(const uid in users){
      console.log( users[uid] );
      $('#playerlist').append(`<div id="user${ uid }"><b>${ users[uid] }</b></div> &nbsp; &nbsp;`)
    }
  }
});


const startGame = (data) => {
  console.log("data from startGame", data);
  state.roles = data.roles;
  state.myRole = state.roles[user_id];

  if( state.myRole === 'mafia' ){
    // indicate all mafia buddies in player list
    for (let key in state.roles) {
      if( state.roles[key] === 'mafia' ){
        $(`#user${ key }`).prepend('(M) ');
      }
    }
  } else {
    // citizen
    $(`#user${ user_id }`).prepend('(C) ');
  }

  $("#start").hide()

  // let citizenPlayers = [];
  // let mafiaPlayers = [];
  // for (var key in roles) {
  //   console.log(key);
  //   if (roles[key]==="citizen") {
  //     citizenPlayers.push(key)
  //   } else {
  //     mafiaPlayers.push(key)
  //   }
  // }
  console.log("user_id before loop", state.roles, user_id);
  for (var key in state.roles) {
    console.log(key);
    if (state.roles[key]==="mafia" && key==user_id) {
        console.log("user_id", user_id);
      $('#mafia_chat_wrapper').show();
    }
  }

}
