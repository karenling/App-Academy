class PostSub < ActiveRecord::Base
  belongs_to(
    :post,
    class_name: 'Post',
    foreign_key: :post_id,
    primary_key: :id
  )
  belongs_to(
    :sub,
    class_name: 'Sub',
    foreign_key: :sub_id,
    primary_key: :id
  )

  validates :post, :sub, presence: true
  validates :post, uniqueness: { scope: :sub }
end
