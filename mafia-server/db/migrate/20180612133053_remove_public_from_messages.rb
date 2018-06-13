class RemovePublicFromMessages < ActiveRecord::Migration[5.2]
  def change
    remove_column :messages, :public, :boolean
  end
end
