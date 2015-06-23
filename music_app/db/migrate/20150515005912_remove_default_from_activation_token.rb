class RemoveDefaultFromActivationToken < ActiveRecord::Migration
  def change
    change_column :users, :activation_token, :string, null: false
  end
end
