class ContactShare < ActiveRecord::Base
  validates :contact_id, presence: true, uniqueness: { scope: :user_id }
  validates :user_id, presence: true

  belongs_to :user
  belongs_to :contact
end
