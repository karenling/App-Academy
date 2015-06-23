class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.integer :owner_id, null: false
      t.string :name, null: false
      t.integer :contact_id, null:false

      t.timestamps null: false
    end

    add_index :groups, [:owner_id, :contact_id, :name], unique: true
    add_index :groups, :owner_id
    add_index :groups, :contact_id
    add_index :groups, :name
  end
end
