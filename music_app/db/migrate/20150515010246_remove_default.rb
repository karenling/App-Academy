class RemoveDefault < ActiveRecord::Migration
  def change
    change_column_default(:users, :activation_token, nil)
  end
end
