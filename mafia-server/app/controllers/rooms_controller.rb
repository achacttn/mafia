class RoomsController < ApplicationController
  def new

  end

  def create
  end

  def show
    @room = Room.find( params[:id] )
  end

  def index
    @rooms = Room.all
  end

  def edit
    
  end

  def update
  end

  def destroy
  end
  private
  def room_params
    params.require(:room).permit(:room_name)
  end
end
