class ChangeUserColumns < ActiveRecord::Migration
  def up
    remove_column :users, :name
    rename_column :users, :email, :username

    add_index :users, :username, :unique => true
  end

  def down
    add_column :users, :name, :string
    rename_column :users, :username, :email
  end
end
