class MessagesController < ApplicationController
  before_action :check_if_logged_in

  # def broadcast
  #   ActionCable.server.broadcast 'messages',
  #     message: @message.text_body,
  #     user: @message.user.name
  #     head :ok
  # end

  def create
    @message = Message.new
    @message.user_id = @current_user.id
    @message.text_body = params[:text_body]
    @message.room_id = params[:room_id]
    @message.save

    if @message.persisted?
      # render :broadcast
      ActionCable.server.broadcast 'messages',
        message: @message.text_body,
        user: @message.user.name
        head :ok

    end
    #
    # raise "hell"
      redirect_to room_path params[:room_id] and return

    # if message.persisted?
    #   redirect_to room_path params[:room_id]
    # else
    #   flash[:errors] = message.errors.full_messages
    #   redirect_to room_path params[:room_id]
    # end
  end



  private

    def message_params
      params.require(:message).permit(:text_body, :room_id)
    end
end
