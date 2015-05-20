class Sub < ActiveRecord::Base
  belongs_to(
    :moderator,
    class_name: 'User',
    foreign_key: :moderator_id,
    primary_key: :id
  )

  has_many(
    :post_subs, dependent: :destroy,
    class_name: 'PostSub',
    foreign_key: :sub_id,
    primary_key: :id
  )

  has_many(
    :posts, dependent: :destroy,
    through: :post_subs,
    source: :post
  )

  validates :title, :moderator, presence: true

end
