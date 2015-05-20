class Vote < ActiveRecord::Base
  belongs_to :votable, polymorphic: true

  validates :value, :votable_type, :votable_id, presence: true
end
