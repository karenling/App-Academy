class AddAdminToUser < ActiveRecord::Migration
  def change
    add_column :users, :admin, :boolean, null: false, default: 0
  end
end
