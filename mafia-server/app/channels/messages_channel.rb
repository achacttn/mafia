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
  end

end
