class RemoveMafiaFromUsers < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :mafia, :boolean
  end
end
