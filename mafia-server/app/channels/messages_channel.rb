# app/channels/messages_channel.rb
class MessagesChannel < ApplicationCable::Channel
  def subscribed
    # puts "subscribed!"
    # binding.pry
    puts "="*100
    p params
    stream_from "room_#{ params[:room_id] }_messages"
  end
end
