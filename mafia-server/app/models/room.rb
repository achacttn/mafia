class Room < ApplicationRecord
    has_many :users
    has_many :messages, dependent: :destroy
    has_many :mafium, dependent: :destroy
    # has_many :gameStates, through: :users
    validates :name,:presence => true
    validates :name,:length => { :minimum => 2 }
    validates :name,uniqueness: true
    serialize :gamestate

    def start_game
      # room.start_game
      self.gamestate[:hasStarted] = true
      self.save
      # broadcast 
    #    ActionCable.server.broadcast "room_#{ @room.id }_messages",
    #     action: 'GAME_START
    end

    def update_current_users
        remainingPlayers = self.users.reject{ |p| p.id == current_user.id }
        self.save
    end

end
