class RoomsController < ApplicationController
  before_action :get_room, only: [:show, :edit, :update, :destroy]
  before_action :check_if_logged_in

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
    # @room = Room.includes(:messages).find( params[:id] )
    @message = Message.new
    @mafia = Mafium.new
    @current_user.update( room_id: params[:id] )
    @current_user.update( stateobject: { mafia: nil, alive: true } )


    ActionCable.server.broadcast "room_#{ @room.id }_messages",
      action: 'PERSON_JOINED',
      name: @current_user.name,
      id: @current_user.id

    if @room.users.length > 2
      @room.update(gamestate: {
        canStart: true,
        hasStarted: false
      })
      # ActionCable.server.broadcast "room_#{ @room.id }_messages",
      #
      #   action: 'GAME_START',
      #   count: 5  # whatever other data you want

    else
      @room.update(gamestate: {
        canStart: false,
        hasStarted: false
      })
    end

    if @room.gamestate[:hasStarted]
      @room.users.sample((@room.users.length/3).floor).each do |player|
        player.stateobject[:mafia] = true
      end

      @room.users.each do |p|
        if !p.stateobject[:mafia]
          p.stateobject[:mafia] = false
        end
      end
    end

    # livingMafia = []
    # livingCitizens = []
    # @room.users.each do |p|
    #   if p.stateobject[:alive]
    #     if p.stateobject[:mafia]
    #       livingMafia.push(p)
    #     else
    #       livingCitizens.push(o)
    #     end
    #   end
    # end

    # def endingCheck()
    #   # check number of livng mafia and living citizens
    #   if livingMafia.length == 0
    #     return true
    #   elsif livingMafia.length > livingCitizens.length
    #     return true
    #   elsif livingMafia.length == 1 && livingCitizens.length == 1
    #     return true
    #   else
    #     return false
    #   end
    # end

  #   if @room.gamestate['hasStarted']

  #     @room.users.sample((@room.users.length/3).floor).each do |player|
  #       player.update(stateobject: { mafia: true})
  #     end
  #     @room.users.each do |p|
  #       if !p.stateobject['mafia']
  #         player.update(stateobject: { mafia: false})
  #       end
  #     end
  #   end
  #   # binding.pry
  #   livingMafia = []
  #   livingCitizens = []
  #   @room.users.each do |p|
  #     if p.stateobject['alive']
  #       if p.stateobject['mafia']
  #         livingMafia.push(p)
  #       else
  #         livingCitizens.push(o)
  #       end
  #     end
  #   end

  #   def endingCheck()
  #     # check number of livng mafia and living citizens
  #     if livingMafia.length == 0
  #       return true
  #     elsif livingMafia.length > livingCitizens.length
  #       return true
  #     elsif livingMafia.length == 1 && livingCitizens.length == 1
  #       return true
  #     else
  #       return false
  #     end
  #   end

  #   def dayTimer()
  #     timeTilDayEnd = 120
  #     while (timeTilDayEnd != 0)
  #       puts timeTilDayEnd
  #       sleep 1
  #       timeTilDayEnd = timeTilDayEnd-1
  #     end
  #   end

  #   def nightTimer()
  #     timeTilNightEnd = 30
  #     while (timeTilNightEnd != 0)
  #       puts timeTilNightEnd
  #       sleep 1
  #       timeTilNightEnd = timeTilNightEnd-1
  #     end
  #   end

  #   dayOrNight = -1

  #   loop do

  #     if (endingCheck())
  #       break
  #     end

  #     if dayOrNight > 0
  #       dayTimer()
  #     else
  #       nightTimer()
  #     end
  #     dayOrNight *= -1
  #   end

    dayOrNight = -1

  #   loop do
  #
  #     if (endingCheck())
  #       break
  #     end
  #
  #     if dayOrNight > 0
  #       dayTimer()
  #     else
  #       nightTimer()
  #     end
  #     dayOrNight *= -1
  #   end
  #
  end


  def broadcast
    ActionCable.server.broadcast 'messages',
      message: @message.text_body,
      user: @message.user.name
      head :ok
  end

  def index
    if @current_user.present?
      @rooms = Room.all
    else
      redirect_to root_path
    end
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
