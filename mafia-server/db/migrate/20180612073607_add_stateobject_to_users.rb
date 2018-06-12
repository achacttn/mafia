class AddStateobjectToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :stateobject, :json, default: {}
  end
end
