class AddSessionTokenToUsers < ActiveRecord::Migration
  def change
    add_column :users, :session_token, :string,
               null: false, default: "session_token"

    add_index :users, :session_token, unique: true
  end
end
