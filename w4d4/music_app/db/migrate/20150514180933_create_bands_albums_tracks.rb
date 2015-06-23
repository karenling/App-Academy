class CreateBandsAlbumsTracks < ActiveRecord::Migration
  def change
    create_table :bands do |t|
      t.string :name, null: false

      t.timestamps null: false
    end

    create_table :albums do |t|
      t.string :name, null: false
      t.integer :band_id, null: false
      t.string :live_studio_type, null: false

      t.timestamps null: false
    end

    create_table :tracks do |t|
      t.string :name, null: false
      t.integer :album_id, null: false
      t.boolean :bonus, null: false
      t.text :lyrics

      t.timestamps null: false
    end

    add_index :bands, :name
    add_index :albums, :band_id
    add_index :albums, :name
    add_index :tracks, :album_id
    add_index :tracks, :name
  end
end
