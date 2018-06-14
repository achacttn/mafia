class AddGamestateToRooms < ActiveRecord::Migration[5.2]
  def change
    add_column :rooms, :gamestate, :json, default: {}
  end
end
