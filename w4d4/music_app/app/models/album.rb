class Album < ActiveRecord::Base
  validates :name, :band_id, :live_studio_type, presence: true

  belongs_to(
    :band,
    class_name: 'Band',
    foreign_key: :band_id,
    primary_key: :id
  )

  has_many(
    :tracks, dependent: :destroy,
    class_name: 'Track',
    foreign_key: :album_id,
    primary_key: :id
  )

end
