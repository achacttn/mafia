class Room < ApplicationRecord
    has_many :users
    has_many :gameStates, through: :users
    validates :name,:presence => true
    validates :name,:length => { :minimum => 2 }
    validates :name,uniqueness: true

end
