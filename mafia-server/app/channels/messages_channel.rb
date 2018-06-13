# app/channels/messages_channel.rb
class MessagesChannel < ApplicationCable::Channel
  def subscribed
    # puts "subscribed!"
    # binding.pry
    puts "="*100
    p params
    stream_from "room_#{ params[:room_id] }_messages"
  end

  # This is actually *receiving* messages from the frontend
  # i.e. via App.room_messages.send_message()
  def send_message( data )
    puts "send_message()"
    p data
    # p Room.all
    p current_user


    case data["event_type"]
    when "start_game"
      puts "START GAME"
      current_user.room.start_game
      
    when "remove_user"
      puts "User removed"
      current_user.room.update_current_users
      current_user.room_id = nil
      ActionCable.server.broadcast "room_#{ params[:room_id]}_messages",
        action: 'UPDATING_PLAYERS',
        message: data[remainingPlayers]
    end


  end

end
