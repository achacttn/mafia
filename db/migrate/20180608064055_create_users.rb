class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.text :name
      t.text :password_digest
      t.text :password_confirmation
      t.boolean :alive
      t.boolean :mafia
      t.text :image

      t.timestamps
    end
  end
end
