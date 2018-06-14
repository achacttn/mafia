// app/assets/javascripts/channels/chatrooms.js

//= require cable
//= require_self
//= require_tree .

this.App = {};

App.cable = ActionCable.createConsumer();

// (function() {
//   this.App || (this.App = {});
//
//   App.cable = ActionCable.createConsumer();
//
// }).call(this);
