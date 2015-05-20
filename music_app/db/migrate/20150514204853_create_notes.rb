class CreateNotes < ActiveRecord::Migration
  def change
    create_table :notes do |t|
      t.text :body, null: false
      t.integer :user_id, null: false
      t.integer :track_id, null: false
      
      t.timestamps
    end
  end
end
