$(document).ready(function () {
  // only use this code in the rooms show page
  if( $('body.rooms.show').length ){

    $('#messages').scrollTop( $('#messages')[0].scrollHeight );

  }
});
