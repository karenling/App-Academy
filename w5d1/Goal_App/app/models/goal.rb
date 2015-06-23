class Goal < ActiveRecord::Base
  belongs_to :user
  validates :body, :user_id, presence: true
  validates :completed, :private_status, inclusion: [true, false]
  validates :body, uniqueness: { scope: :user_id }
end
