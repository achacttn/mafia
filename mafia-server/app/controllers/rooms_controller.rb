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
    # @room = Room.find( params[:id] )
    @room = Room.includes(:messages).find( params[:id] )
    @message = Message.new
  end

  def broadcast
    ActionCable.server.broadcast 'messages',
      message: @message.text_body,
      user: @message.user.name
      head :ok
  end

  def messages
    @message = Message.new(message_params)
    @message.user_id = @current_user.id
    @message.text_body = params[:text_body]
    @message.room_id = params[:room_id]
    @message.save

    if @message.save
      render :broadcast
      # ActionCable.server.broadcast 'messages',
      #   message: message.text_body,
      #   user: message.user.name
      #   head :ok
    end
    #
    raise "hell"
    redirect_to room_path params[:room_id]
    # if message.persisted?
    #   redirect_to room_path params[:room_id]
    # else
    #   flash[:errors] = message.errors.full_messages
    #   redirect_to room_path params[:room_id]
    # end
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
