class CreateRooms < ActiveRecord::Migration[5.2]
  def change
    create_table :rooms do |t|
      t.text :name
      t.integer :playerCount

      t.timestamps
    end
  end
end
