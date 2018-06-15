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

        puts "Room.game_start(): "
        puts "     current users: #{ self.users.count }"
        puts "     #{ self.users.pluck(:id, :name) }"

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

        puts "Roles assigned: "

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

    def register_vote(voting_user, type, vote_user_id)
      # ignore invalid votes
      puts "register_vote(#{ voting_user.id }): type=#{ type }, vote_user_id=#{ vote_user_id }"
      p voting_user
      p self

      self.reload
      while self.gamestate[:vote_lock]
        puts "%%%%%%%%%%%%%%%%%%%%%%%%%% LOCKED!"
        sleep 0.2
        self.reload
      end

      self.gamestate[:vote_lock] = true
      self.save

      self.gamestate[:votes] ||= {}

      # make sure vote is present (i.e. user voted in time)
      if vote_user_id.present?
        if type == 'day' || self.gamestate[:roles][voting_user.id] == 'mafia'
          puts "COUNTED VOTE:"
          p type
          p self.gamestate[:roles][voting_user.id]
          p type == 'night'
          p self.gamestate[:roles][voting_user.id] == 'citizen'

          current_vote_for_user = self.gamestate[:votes][vote_user_id] || 0
          self.gamestate[:votes][vote_user_id] = current_vote_for_user + 1
          self.save
          puts "UPDATED VOTE COUNT:"
          p self.gamestate
        else
          puts "NOT ALLOWED TO VOTE!!! #{ voting_user.id }";
          p type
          p self.gamestate[:roles][voting_user.id]
          p type == 'night'
          p self.gamestate[:roles][voting_user.id] == 'citizen'

          # p type, self.gamestate[:roles][voting_user] == 'citizen'
          # p voting_user.stateobject[:mafia], voting_user.stateobject[:mafia] == false
          puts; puts
        end
      else
        puts "VOTE INVALID FOR #{ voting_user.id }"; puts;puts
      end

      current_vote_count = self.gamestate[:vote_count] || 0
      self.gamestate[:vote_count] = current_vote_count + 1
      self.save
      
      puts "UPDATED VOTE COUNT:"
      p self.gamestate


      if self.gamestate[:vote_count] == self.users.length
        puts "TALLY TIME========================"
        # tally votes: 3 players ONLY!
        death = nil
        if self.gamestate[:votes].has_value? 3
          death = self.gamestate[:votes].key 3
          puts "3 votes for #{ death }"
        elsif self.gamestate[:votes].has_value? 2
          death = self.gamestate[:votes].key 2
          puts "2 votes for #{ death }"
        elsif self.gamestate[:votes].values.length == 1 && self.gamestate[:votes].values.first == 1
          death = self.gamestate[:votes].key 1
          puts "1 vote for #{ death }"
        end

        if death
          victim = User.find( death )
          victim.stateobject[:alive] = false
          puts "UPDATED VICTIM:"
          p victim
          victim.save
        end

        # broadcast death or at least start of next round
        ActionCable.server.broadcast "room_#{ self.id }_messages",
          action: 'NEXT_ROUND',
          death: death


        self.gamestate.delete( :votes )
        self.gamestate.delete( :vote_count )
        self.save
      end # tally block

      # free lock
      self.gamestate.delete( :vote_lock )
      self.save


      puts "EEEEEEEEEEEEEEEEEND register_vote(#{ voting_user.id }):"
      p self

    end


    # def update_current_users
    #     self.remainingPlayers = self.users.reject{ |p| p.id == current_user.id }
    #     puts '#'*100
    #     self.save
    # end





end
