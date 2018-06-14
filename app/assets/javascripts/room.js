
let state = {};
let tick = 20;
let tickId;

$(document).ready(function () {
  // only use this code in the rooms show page

  if( $('body.rooms.show').length ){
    console.log("users", users);
    console.log("usersStatus", usersStatus);

    $('#messages').scrollTop( $('#messages')[0].scrollHeight );
    $("#mafiaChannel").scrollTop($("#mafiaChannel")[0].scrollHeight);

//existing players
    for(const uid in users){
      console.log( users[uid] );
      let bbb = `<div id="user${ uid }"><b>${ users[uid] }</b>&nbsp;&nbsp;<input type="radio" name="vote"  value="${uid}"></div>`;

      $('#playerlist').append(bbb)
    }
  }
});


const updateTick = () => {
  $('#tick').html(tick)
  tick--
}

// const endNight = () => {
//     clearInterval(tickId);
  // $("input[name='vote']:checked").val()
  // startDay();
//
// }

const startDay = () => {
  console.log("startDay");
}


const startNight =() => {

  tickId = setInterval(updateTick, 1000);
  // setTimeout(function(){clearInterval(tickId)}, 21000);
    setTimeout( function(){
      clearInterval(tickId);
      $("input[name='vote']:checked").val()


      ActionCable.server.broadcast `room_${ room_id }_messages`,
        action: 'COLLECT_VOTES',
        votes: 
      startDay();

  } , 21000);
}


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

  console.log("user_id before loop", state.roles, user_id);
  for (var key in state.roles) {
    console.log(key);
    if (state.roles[key]==="mafia" && key==user_id) {
        console.log("user_id", user_id);
      $('#mafia_chat_wrapper').show();
    }
  }
  startNight()//invoke start night
}// game started
