class VoteMessagesChannel < ApplicationCable::Channel
  def subscribed
    stream_from "vote_room_#{ params[:room_id]}_messages"
  end


  def send_voted_message(data)
    Action.server.broadcast "vote_room_#{params[:room_id]}_messages",
     action: "add"
  end

  def send_reduce_message(data)
    Action.server.broadcast "vote_room_#{params[:room_id]}_messages",
     action: "subtract"
  end
end
