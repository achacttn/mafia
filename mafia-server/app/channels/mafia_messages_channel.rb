# app/channels/messages_channel.rb
class MafiaMessagesChannel < ApplicationCable::Channel
  def subscribed
    # puts "subscribed!"
    # binding.pry
    puts "="*100
    p params
    stream_from "mafia_room#{ params[:room_id] }_messages"
  end
end
