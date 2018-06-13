# app/channels/messages_channel.rb
class MafiaMessagesChannel < ApplicationCable::Channel
  def subscribed
    # puts "subscribed!"
    # binding.pry
    puts "="*100
    p params
    # if current_user.stateobject[:mafia]
      stream_from "mafia_room#{ current_user.room_id }_messages"
    # end
  end

  def send_message( data )
    puts "MAFIA send_message()"
    p data
    # p Room.all
    p current_user

     m = Mafium.create user_id: current_user.id, text_body: data["message"], room_id: current_user.room_id

     p m.errors

    ActionCable.server.broadcast "mafia_room#{ current_user.room_id }_messages",
      action: 'message',
      message: data["message"],
      user: current_user.name

  end


end
