class AddActivatedAndActivationTokenToUser < ActiveRecord::Migration
  def change
    add_column :users, :activated, :boolean, null: false, default: 0
    add_column :users, :activation_token, :string,
                default: SecureRandom::urlsafe_base64
  end
end
