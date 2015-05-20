class AddFavoriteToContactShare < ActiveRecord::Migration
  def change
    add_column :contact_shares, :favorite, :boolean, default: false
  end
end
