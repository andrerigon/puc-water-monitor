class AddAdminAndReceiveUpdatesToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :admin, :boolean, default: false, null: false
    add_column :users, :receive_updates, :boolean, default: false, null: false
  end
end