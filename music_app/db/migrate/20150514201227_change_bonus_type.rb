class ChangeBonusType < ActiveRecord::Migration
  def change
    change_column :tracks, :bonus, :text
  end
end
