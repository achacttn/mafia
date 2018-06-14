class Mafium < ApplicationRecord
  belongs_to :room
  belongs_to :user
  validates :text_body, :presence => true
  validates :text_body, :length => { :minimum => 2 }
end


# mafia-server$ rails g model Mafia text_body:text room_id:integer user_id:integer
# message received from terminal:
# [WARNING] The model name 'Mafia' was recognized as a plural, using the singular 'Mafium' instead. Override with --force-plural or setup custom inflection rules for this noun before running the generator.
