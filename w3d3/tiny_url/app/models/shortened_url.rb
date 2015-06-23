# == Schema Information
#
# Table name: shortened_urls
#
#  id           :integer          not null, primary key
#  long_url     :string           not null
#  short_url    :string           not null
#  submitter_id :integer          not null
#  created_at   :datetime
#  updated_at   :datetime
#

class ShortenedUrl < ActiveRecord::Base
  validate :long_url, :no_spamming
  validates :long_url, uniqueness: true, length: {maximum: 1024} #, :no_spamming
  validates :short_url, uniqueness: true
  validates :submitter_id, :long_url, :short_url, presence: true

  belongs_to(
    :submitter,
    class_name: 'User',
    foreign_key: :submitter_id,
    primary_key: :id
  )

  has_many(
    :visits,
    class_name: 'Visit',
    foreign_key: :url_id,
    primary_key: :id
  )

  has_many(
    :visitors,
    through: :visits,
    source: :visitor
  )

  has_many(
    :distinct_visitors,
    -> { distinct },
    through: :visits,
    source: :visitor
  )

  has_many(
    :taggings,
    class_name: 'Tagging',
    foreign_key: :url_id,
    primary_key: :id
  )

  has_many(
    :tags,
    through: :taggings,
    source: :tag_topic_name
  )

  def self.random_code
    code = ''
    loop do
      code = SecureRandom.urlsafe_base64
      break if !ShortenedUrl.exists?(:short_url => code)
    end
    code
  end

  def self.create_for_user_and_long_url!(user, long_url)
    ShortenedUrl.create!({
      :long_url => long_url,
      :submitter_id => user.id,
      :short_url => ShortenedUrl.random_code})
  end

  def num_clicks
    self.visitors.count
  end

  def num_uniques
    self.distinct_visitors.count
  end

  def num_recent_uniques
    self.distinct_visitors.where("visits.created_at > ?", 10.minutes.ago).count
  end

#  def no_spamming
#    recent_urls = User.find(submitter_id).submitted_urls.where("shortened_urls.created_at > ?", 10.minutes.ago)
#    recent_urls.count > 5 ? false : true
#  end

  def no_spamming#(record, attribute_name, value)
    recent_urls = User.find(submitter_id).submitted_urls.where("shortened_urls.created_at > ?", 10.minutes.ago)
    unless recent_urls.count < 5
      errors[:base] << "you have been entering way too many urls."
    end
  end
end


#ShortenedUrl.create_for_user_and_long_url!(User.first, 'google.com')
