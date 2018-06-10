class MessagesController < ApplicationController
  before_action :check_if_logged_in

  def create
    message = Message.new(message_params)
    message.user = @current_user
    # message.room_id = params[:room_id]
    message.save
    redirect_to room_path
    raise 'hell'
  end

  private

    def message_params
      params.require(:message).permit(:text_body, :room_id)
    end
end