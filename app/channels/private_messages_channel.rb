class PrivateMessagesChannel < ApplicationCable::Channel
  def subscribed
    # puts "subscribed!"
    # puts "="*100
    # p params
    # p "USER", current_user
    # binding.pry
    # current_user is a method defined in app/channels/application_cable/connection.rb
    stream_from "private_#{ current_user.id }_messages"
  end
end
