class Cat < ActiveRecord::Base
  has_many(
    :rentals, dependent: :destroy,
    class_name: 'CatRentalRequest',
    foreign_key: :cat_id,
    primary_key: :id
  )

  # has_many :rentals, dependent: :destroy

  COLORS = [
    "RED",
    "BLACK",
    "WHITE",
    "BROWN",
    "GRAY"
  ]

  SEXES = ["M", "F"]

  validates :birth_date, :color, :name, :sex, presence: true
  validates :sex, inclusion: SEXES
  validates :color, inclusion: COLORS

  def age
    ((Time.now - self.birth_date)/(60*60*24*365)).round
  end
end










# Cat.create!(birth_date: "2000-01-01", color: "RED", name: 'Gizmo', sex: "M")
