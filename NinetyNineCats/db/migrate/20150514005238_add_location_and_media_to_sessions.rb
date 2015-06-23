class AddLocationAndMediaToSessions < ActiveRecord::Migration
  def change
    add_column :sessions, :media, :string, null: false, default: "Unknown"
    add_column :sessions, :location, :string, null: false, default: "Unknown"
  end
end
