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
        puts '+'*100
        # broadcast
        #    ActionCable.server.broadcast "room_#{ @room.id }_messages",
        #     action: 'GAME_START


        roles = {}

        # select the correct proportion of players to be mafia, randomly chosen
        self.users.sample((self.users.length/3).floor).each do |player|
            p 'hash', player.stateobject
            player.stateobject[:mafia] = true
            roles[player.id] = 'mafia';
            player.save
        end

        # remaining players are citizens
        self.users.each do |p|
            if !p.stateobject[:mafia]
                p.stateobject[:mafia] = false
                roles[p.id] = 'citizen';
                p.save
            end
        end

        self.users.each do |u|
            puts u.stateobject
            puts '2'*100
        end

        puts "=" * 100
        p roles

        # binding.pry

        self.gamestate[:roles] = roles
        self.save
        puts self.gamestate[:hasStarted]
        puts '3'*100
    end

    # def update_current_users
    #     self.remainingPlayers = self.users.reject{ |p| p.id == current_user.id }
    #     puts '#'*100
    #     self.save
    # end





end
