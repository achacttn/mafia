class User < ApplicationRecord
  has_secure_password
  belongs_to :room, optional: true, dependent: :destroy
  validates :name, presence: true
  validates :password, presence: true, on: :create

  # has_many :gameStates, through: :rooms
  has_many :messages, dependent: :destroy
  has_many :mafium, dependent: :destroy
  serialize :stateobject

  # def update_current_users
  #     self.remainingPlayers = self.users.reject{ |p| p.id == @current_user.id }
  #     puts '#'*100
  #     self.save
  # end

end
