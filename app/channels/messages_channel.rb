# app/channels/messages_channel.rb
class MessagesChannel < ApplicationCable::Channel
  def subscribed
    # puts "subscribed!"
    # binding.pry
    # puts "="*100
    # p params
    stream_from "room_#{ params[:room_id] }_messages"

    puts "J"*100
    puts "Joined:", current_user

    ActionCable.server.broadcast "room_#{ params[:room_id] }_messages",
      action: 'PERSON_JOINED',
      name: current_user.name,
      id: current_user.id

  end

  def unsubscribed
    puts "=========== UNSUBSCRIBED"
    p current_user

    room_id = current_user.room_id

    current_user.update room_id: nil

    ActionCable.server.broadcast "room_#{ room_id }_messages",
      action: 'PERSON_LEFT',
      name: current_user.name,
      id: current_user.id

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
      #step 1: method in the room model to indicate the state to start (true)
      current_user.room.start_game
      p current_user.room_id
      #step 2: to broadcast game start state change to all users in the room:
      ActionCable.server.broadcast "room_#{ params[:room_id]}_messages", action: 'GAME_HAS_STARTED', roles: current_user.room.gamestate[:roles]

    when "remove_user"
      puts "User removed!!!"
      puts "="*100
      p current_user.room_id
      puts '1'*100
      current_user.room.update_current_users
      remainingPlayers.each do |p|
        puts p.id
        puts "="*100
      end
      current_user.room_id = nil
      ActionCable.server.broadcast "room_#{ params[:room_id]}_messages",
        action: 'UPDATING_PLAYERS',
        message: data[remainingPlayers]

    when "submit_vote"
      puts "*" * 100
      puts data

      current_user.room.register_vote(
        current_user,
        data["vote_type"],
        data["vote"]
      )

    end  # case


  end # send_message()

end
