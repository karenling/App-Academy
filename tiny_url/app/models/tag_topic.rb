class TagTopic < ActiveRecord::Base
  validates :topic, :presence => true, :uniqueness => true

  has_many(
    :taggings,
    class_name: 'Tagging',
    foreign_key: :tag_topic_id,
    primary_key: :id
  )

  has_many(
    :tagged_urls,
    through: :taggings,
    source: :shortened_url
  )

  has_many(
    :users,
    through: :tagged_urls,
    source: :submitter
  )
end
