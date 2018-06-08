class Room < ApplicationRecord
  has_many :users
  has_many :gameStates
end
