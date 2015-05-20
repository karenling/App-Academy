class Post < ActiveRecord::Base
  belongs_to(
    :author,
    class_name: 'User',
    foreign_key: :author_id,
    primary_key: :id
  )

  has_many(
    :post_subs, dependent: :destroy,
    class_name: 'PostSub',
    foreign_key: :post_id,
    primary_key: :id,
    inverse_of: :post
  )

  has_many(
    :subs,
    through: :post_subs,
    source: :sub
  )

  has_many(
    :comments, dependent: :destroy,
    class_name: 'Comment',
    foreign_key: :post_id,
    primary_key: :id
  )
  has_many(
    :parent_comments,
    through: :comments,
    source: :parent_comment
  )
  has_many(
    :child_comments,
    through: :comments,
    source: :child_comments
  )
  has_many :votes, as: :votable, dependent: :destroy

  validates :title, :author_id, :post_subs, presence: true

  def vote_value
    self.votes.pluck(:value).inject(:+)
  end


end
