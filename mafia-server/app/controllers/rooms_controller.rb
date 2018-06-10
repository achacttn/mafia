class RoomsController < ApplicationController
  before_action :get_room, only: [:show, :edit, :update, :destroy]
  before_action :check_if_logged_in, except: [:index, :show]


  def new
    @room = Room.new
  end

  def create
    @room = Room.new room_params
    if params[:file].present?
      req = Cloudinary::Uploader.upload(params[:file])
      @room.image = req["public_id"]
    end
    @room.save

    if @room.persisted?
      redirect_to rooms_path


    else
      flash[:errors] = @room.errors.full_messages
      redirect_to new_room_path
    end
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
    @room.update room_params
    if params[:file].present?
      req = Cloudinary::Uploader.upload(params[:file])
      @room.image = req["public_id"]
    end
    @room.update_attributes(room_params)
    @room.save
    redirect_to rooms_path
  end


  def destroy
    @room.destroy
    redirect_to rooms_path
  end

  private
  def room_params
    params.require(:room).permit(:name, :description)
  end

  def get_room
    @room = Room.find params[:id]
  end
end
