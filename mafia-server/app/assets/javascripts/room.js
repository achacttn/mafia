$(document).ready(function () {
  // only use this code in the rooms show page
  if( $('body.rooms.show').length ){

    $('#messages').scrollTop( $('#messages')[0].scrollHeight );
    
  }
});


const startGame = (data) => {
  console.log("data from startGame", data);
  let roles = data.roles
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
  console.log("user_id before loop", roles, user_id);
  for (var key in roles) {
    console.log(key);
    if (roles[key]==="mafia" && key==user_id) {
        console.log("user_id", user_id);
      $('#mafia_chat_wrapper').show();
    }
  }
}
