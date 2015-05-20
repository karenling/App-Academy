class AddFavoriteToContacts < ActiveRecord::Migration
  def change
    add_column :contacts, :favorite, :boolean, default: false
  end
end
