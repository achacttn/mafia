class AddPublicToMessages < ActiveRecord::Migration[5.2]
  def change
    add_column :messages, :public, :boolean
  end
end
