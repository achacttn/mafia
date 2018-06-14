class MafiasController < ApplicationController
  before_action :check_if_logged_in

  def create
    # raise "hell"
    # binding.pry
    @mafia = Mafium.new mafia_params
    @mafia.user = @current_user

    if @mafia.save

      p @mafia.text_body
      p @mafia.user

      ActionCable.server.broadcast "mafia_#{ params[:mafia][:room_id] }_messages",
        message: @mafia.text_body,
        user: @mafia.user.name

      head :ok
    # else
    #   binding.pry
    end
    binding.pry
  end


  private

    def mafia_params
      params.require(:mafia).permit(:text_body, :room_id)
    end
end
