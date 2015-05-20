class CreateGoals < ActiveRecord::Migration
  def change
    create_table :goals do |t|
      t.string :body, null: false
      t.integer :user_id, null: false
      t.boolean :completed, null: false, default: false
      t.boolean :private_status, null: false, default: true

      t.timestamps
    end
    add_index :goals, :user_id
    add_index :goals, [:user_id, :body], unique: true
  end
end
