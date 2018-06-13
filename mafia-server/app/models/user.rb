class User < ApplicationRecord
  has_secure_password
  belongs_to :rooms, optional: true, dependent: :destroy
  validates :name, presence: true
  validates :password, presence: true, on: :create

  # has_many :gameStates, through: :rooms
  has_many :messages, dependent: :destroy
  has_many :mafium, dependent: :destroy
  serialize :stateobject

end
