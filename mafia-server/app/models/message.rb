class Message < ApplicationRecord
    belongs_to :room
    belongs_to :user
    validates :text_body, :presence => true
    validates :text_body, :length => { :minimum => 2 }


end
