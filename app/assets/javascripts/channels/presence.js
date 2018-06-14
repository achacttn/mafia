// $(document.ready(function(){

//     App.room_presence = App.cable.subscriptions.create({
//         channel: 'PresenceChannel', room_id: room_id }, {

//             connection(){
//                 this.install();
//                 return this.appear();
//             },

//             disconnected(){
//                 return this.uninstall();
//             },

//             rejected(){
//                 return this.uninstall();
//             },

//             appear(){
//                 return this.perform("appear", { appearing_on: $("main").data("appearing-on") });
//             },


//         })

// }))