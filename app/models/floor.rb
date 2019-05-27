class Floor < ApplicationRecord
  belongs_to :venue

  has_many :sections
  has_many :seats, through: :sections

  def price_ranges
    [
      (5_00...10_00),
      (10_00...15_00),
      (15_00...)
    ]
  end

  def to_param
    slug
  end
end
