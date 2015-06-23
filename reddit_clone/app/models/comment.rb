class Comment < ActiveRecord::Base
  belongs_to(
    :author,
    class_name: 'User',
    foreign_key: :author_id,
    primary_key: :id
  )
  belongs_to(
    :post,
    class_name: 'Post',
    foreign_key: :post_id,
    primary_key: :id
  )
  belongs_to(
    :parent_comment,
    class_name: 'Comment',
    foreign_key: :parent_comment_id,
    primary_key: :id
  )
  has_many(
    :child_comments, dependent: :destroy,
    class_name: 'Comment',
    foreign_key: :parent_comment_id,
    primary_key: :id
  )
  has_many :votes, as: :votable, dependent: :destroy

  validates :content, :author_id, :post_id, presence: true

  def vote_value
    self.votes.pluck(:value).inject(:+)
  end
end
