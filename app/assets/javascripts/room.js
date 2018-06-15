
let state = {};
// let tick = 20;
// let tickId;

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
      let bbb = `<div id="user${ uid }"><b>${ users[uid] }</b>&nbsp;&nbsp;<input type="radio" name="vote"  value="${uid} id=${uid}"></div>`;

      $('#playerlist').append(bbb);
    }
  }
});


// const updateTick = () => {
//   $('#tick').html(tick)
//   tick--
// }

// const endNight = () => {
//     clearInterval(tickId);
  // $("input[name='vote']:checked").val()
  // startDay();
//
// }

// const startDay = () => {
//   console.log("startDay");
// }


// const startNight =() => {
//
//   tickId = setInterval(updateTick, 1000);
//   // setTimeout(function(){clearInterval(tickId)}, 21000);
//     setTimeout( function(){
//       clearInterval(tickId);
//       $("input[name='vote']:checked").val()
//
//       startDay();
//   } , 30000);
// }

  let startDay;
  let startNight;

  startNight = (nightTimer) =>{

    let night = 20;
    $("#timerNightDisplay").show();
    $("#timerNight").toggle();
    nightTimer = setInterval(()=>{
    night --;
    $("#timerNight").html(night);
      if(night === 0){
        console.log(night);
        clearInterval(nightTimer);

        App.room_messages.send_message({
          event_type: 'submit_vote',
          vote_type: 'night',
          vote: $("input[name='vote']:checked").val()
        });

        //
        // startDay();
        startDay();
        $("#timerNightDisplay").hide();
        $("#timerNight").toggle();


      }
    },1000);

  };

  startDay = (dayTimer) =>{

    let day = 120;
    $("#timerDayDisplay").show();
    $("#timerDay").toggle();
    dayTimer = setInterval(()=>{
    day --;
    $("#timerDay").html(day);
    if(day === 0){

        clearInterval(dayTimer);


        App.room_messages.send_message({
          event_type: 'submit_vote',
          vote_type: 'day',
          vote: $("input[name='vote']:checked").val()
        });

        startNight();
      }
  },1000);
  };

  // startPause = (dayTimer) =>{
  //   let pause = 10;
  //     pauseTimer = setInterval(()=>{
  //     pause --;
  //   if(pause === 0){
  //       clearInterval(pause);
  //
  //     }
  //   },1000);
  // };

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
  startNight()
  //invoke start night
}// game started
